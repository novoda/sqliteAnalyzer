package com.novoda.sqlite.generator

class Templates {

    static final String FULL_ACCESS = '''\
package $packageName;

public final class $className {
public static final class Tables {
<% access.tables.each { dataSet -> %>\
    public static final String $dataSet.name = "$dataSet.sqlName";
<% } %>\
}

public static final class Columns {
<% access.tables.each { dataSet -> %>\
    public static final class $dataSet.name {
<%      dataSet.fields.each { field -> %>\
        public static final String $field.accessor = "$field.sqlName";
<%      } %>\
    }
<% } %>\
}

<% access.tables.each { dataSet -> %>\
public static final class $dataSet.name {
<% dataSet.fields.each { field -> %>\
    public static $field.type $field.getMethod(android.database.Cursor cursor) {
        int index = cursor.getColumnIndexOrThrow("$field.sqlName");
<% if(field.optional) {%>\
        if (cursor.isNull(index)) {
            return null;
        }
<% } %>\
        return cursor.get$field.cursorType(index)<% if (field.type ==~ /^(?i)boolean$/) out << " > 0" %>;
    }
    public static void $field.setMethod($field.type value, android.content.ContentValues values) {
        values.put("$field.sqlName", value);
    }
<% } %>\

    public static $dataSet.name fromCursor(android.database.Cursor cursor) {
<% dataSet.fields.each { field -> %>\
        $field.type $field.name = $field.getMethod(cursor);
<% } %>\
        return new $dataSet.name(\
<% out << dataSet.fields.collect { it.name }.join(', ') %>);
    }

<% dataSet.fields.each { field -> %>\
    private final $field.type $field.name;
<% } %>\

    public $dataSet.name(\
<% out << dataSet.fields.collect {"$it.type $it.name"}.join(', ') %>) {
<% dataSet.fields.each { field -> %>\
        this.$field.name = $field.name;
<% } %>\
    }

<% dataSet.fields.each { field -> %>\
    public final $field.type $field.getMethod() {
        return $field.name;
    }
<% } %>\
    public android.content.ContentValues toContentValues() {
        android.content.ContentValues values = new android.content.ContentValues();
<% dataSet.fields.each { field -> %>\
        $field.setMethod($field.name, values);
<% } %>\
        return values;
    }
}
<% } %>\
}
'''

    static final String ONLY_STATIC_ACCESS = '''\
package $packageName;

public final class $className {
public static final class Tables {
<% access.tables.each { dataSet -> %>\
    public static final String $dataSet.name = "$dataSet.sqlName";
<% } %>\
}

public static final class Columns {
<% access.tables.each { dataSet -> %>\
    public static final class $dataSet.name {
<%      dataSet.fields.each { field -> %>\
        public static final String $field.accessor = "$field.sqlName";
<%      } %>\
    }
<% } %>\
}

<% access.tables.each { dataSet -> %>\
public static final class $dataSet.name {
<% dataSet.fields.each { field -> %>\
    public static $field.type $field.getMethod(android.database.Cursor cursor) {
        int index = cursor.getColumnIndexOrThrow("$field.sqlName");
<% if(field.optional) {%>\
        if (cursor.isNull(index)) {
            return null;
        }
<% } %>\
        return cursor.get$field.cursorType(index)<% if (field.type ==~ /^(?i)boolean$/) out << " > 0" %>;
    }
    public static void $field.setMethod($field.type value, android.content.ContentValues values) {
        values.put("$field.sqlName", value);
    }
<% } %>\
}
<% } %>\
}
'''

}
