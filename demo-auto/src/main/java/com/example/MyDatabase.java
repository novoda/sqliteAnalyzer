package com.example;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteQueryBuilder;

import com.example.sqlite.DB;
import com.readystatesoftware.sqliteasset.SQLiteAssetHelper;

import static com.example.sqlite.DB.Columns.Employees;

public class MyDatabase extends SQLiteAssetHelper {

	private static final String DATABASE_NAME = "northwind.db";
	private static final int DATABASE_VERSION = 1;
	
	public MyDatabase(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
		
		// you can use an alternate constructor to specify a database location 
		// (such as a folder on the sd card)
		// you must ensure that this folder is available and you have permission
		// to write to it
		//super(context, DATABASE_NAME, context.getExternalFilesDir(null).getAbsolutePath(), null, DATABASE_VERSION);
		
	}

	public Cursor getEmployees() {

		SQLiteDatabase db = getReadableDatabase();
		SQLiteQueryBuilder qb = new SQLiteQueryBuilder();

		String [] sqlSelect = {"0 _id", Employees.Firstname, Employees.Lastname};
		String sqlTables = DB.Tables.Employees;

		qb.setTables(sqlTables);
		Cursor c = qb.query(db, sqlSelect, null, null,
				null, null, null);

		c.moveToFirst();
		return c;

	}

}
