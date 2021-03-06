ALTER TABLE VIDEOS_RAW ADD COLUMN "GEO_BLOCKING_ORD" INTEGER;

DROP VIEW "VIDEOS";
CREATE VIEW IF NOT EXISTS "VIDEOS" AS SELECT VIDEOS_RAW._id as _id, VIDEOS_RAW.REF_ID, VIDEOS_RAW.LANGUAGE_ID, VIDEOS_RAW.STREAM_ID, VIDEOS_RAW.PROGRAM_ID, VIDEOS_RAW.TYPE, VIDEOS_RAW.TITLE, VIDEOS_RAW.TEXT, VIDEOS_RAW.SUBTITLE, VIDEOS_RAW.DURATION, VIDEOS_RAW.THUMBNAIL_URL, VIDEOS_RAW.POSITION, VIDEOS_RAW.DATE, VIDEOS_RAW.RIGHTS_AFTER, VIDEOS_RAW.RIGHTS_UNTIL, VIDEOS_RAW.ADULT, VIDEOS_RAW.WARNING, VIDEOS_RAW.VIDEO_VIEWS, VIDEOS_RAW.RATING, VIDEOS_RAW.RECOMMENDED, VIDEOS_RAW.PLUS7_TEASER, VIDEOS_RAW.RANK, VIDEOS_RAW.GEO_BLOCKING, VIDEOS_RAW.GEO_BLOCKING_ORD, VIDEOS_RAW.ISO_LANG, VIDEOS_RAW.WATCH_POSITION, PROGRAMS.TITLE AS PROGRAM_TITLE FROM VIDEOS_RAW OUTER LEFT JOIN PROGRAMS ON VIDEOS_RAW.PROGRAM_ID = PROGRAMS.PROGRAM_ID AND VIDEOS_RAW.LANGUAGE_ID = PROGRAMS.LANGUAGE_ID;

DROP VIEW "PROGRAMS_SEARCH_RESULT";
CREATE VIEW IF NOT EXISTS "PROGRAMS_SEARCH_RESULT" AS SELECT PROGRAMS._ID, PROGRAMS.TITLE, PROGRAMS.PROGRAM_ID, VIDEOS.TYPE, VIDEOS.DURATION, VIDEOS.VIDEO_VIEWS, VIDEOS.RIGHTS_AFTER, VIDEOS.RIGHTS_UNTIL, VIDEOS.THUMBNAIL_URL, VIDEOS.GEO_BLOCKING, VIDEOS.GEO_BLOCKING_ORD, PROGRAMS.LANGUAGE_ID FROM PROGRAMS INNER JOIN VIDEOS ON PROGRAMS.DEFAULT_VIDEO_ID = VIDEOS.REF_ID;

DROP VIEW "VIDEOS_BY_CLUSTER";
CREATE VIEW IF NOT EXISTS "VIDEOS_BY_CLUSTER" AS SELECT DISTINCT VIDEOS._id, BROADCASTS.PROGRAM_ID, VIDEOS.TITLE, VIDEOS.TYPE, VIDEOS.THUMBNAIL_URL, VIDEOS.DURATION, VIDEOS.VIDEO_VIEWS, VIDEOS.RIGHTS_AFTER, VIDEOS.RIGHTS_UNTIL, CLUSTERS.TITLE AS CLUSTER, CLUSTERS.CLUSTER_ID AS CLUSTER_ID, VIDEOS.GEO_BLOCKING, VIDEOS.GEO_BLOCKING_ORD, PROGRAMS.LANGUAGE_ID FROM BROADCASTS LEFT OUTER JOIN PROGRAMS ON BROADCASTS.PROGRAM_ID = PROGRAMS.PROGRAM_ID AND BROADCASTS.LANGUAGE_ID = PROGRAMS.LANGUAGE_ID INNER JOIN VIDEOS ON VIDEOS.PROGRAM_ID = PROGRAMS.PROGRAM_ID AND VIDEOS.LANGUAGE_ID = PROGRAMS.LANGUAGE_ID INNER JOIN CLUSTERS ON BROADCASTS.MAIN_CLUSTER_ID = CLUSTERS.CLUSTER_ID ORDER BY VIDEOS.TITLE ASC;

DROP VIEW "VIDEOS_BY_CHANNEL";
CREATE VIEW IF NOT EXISTS "VIDEOS_BY_CHANNEL" AS SELECT DISTINCT VIDEOS._id, VIDEOS.TITLE, VIDEOS.TYPE, VIDEOS.THUMBNAIL_URL, VIDEOS.DURATION, VIDEOS.VIDEO_VIEWS, VIDEOS.RIGHTS_AFTER, VIDEOS.RIGHTS_UNTIL, VIDEO_CHANNEL.CHANNEL_ID, VIDEOS.PROGRAM_ID, VIDEOS.GEO_BLOCKING, VIDEOS.GEO_BLOCKING_ORD, VIDEO_CHANNEL.LANGUAGE_ID FROM VIDEOS INNER JOIN VIDEO_CHANNEL ON VIDEO_CHANNEL.VIDEO_ID = VIDEOS.REF_ID ORDER BY VIDEOS.TITLE ASC;

DROP VIEW "CLUSTERS_WITH_VIDEO";
CREATE VIEW IF NOT EXISTS "CLUSTERS_WITH_VIDEO" AS SELECT DISTINCT CLUSTERS._id, CLUSTERS.TITLE, CLUSTERS.CLUSTER_ID, CLUSTERS.IMAGE_URL, VIDEOS.LANGUAGE_ID, VIDEOS.GEO_BLOCKING_ORD FROM BROADCASTS INNER JOIN PROGRAMS ON BROADCASTS.PROGRAM_ID = PROGRAMS.PROGRAM_ID AND BROADCASTS.LANGUAGE_ID = PROGRAMS.LANGUAGE_ID INNER JOIN VIDEOS ON VIDEOS.PROGRAM_ID = PROGRAMS.PROGRAM_ID AND VIDEOS.LANGUAGE_ID = PROGRAMS.LANGUAGE_ID INNER JOIN CLUSTERS ON BROADCASTS.MAIN_CLUSTER_ID = CLUSTERS.CLUSTER_ID ORDER BY CLUSTERS.TITLE ASC;

DROP VIEW "GENRES_WITH_VIDEO";
CREATE VIEW IF NOT EXISTS "GENRES_WITH_VIDEO" AS SELECT DISTINCT GENRES._id, GENRES.LABEL, GENRES.CODE, PROGRAMS.LANGUAGE_ID, VIDEOS.GEO_BLOCKING_ORD FROM PROGRAMS INNER JOIN VIDEOS ON VIDEOS.PROGRAM_ID = PROGRAMS.PROGRAM_ID AND VIDEOS.LANGUAGE_ID = PROGRAMS.LANGUAGE_ID INNER JOIN GENRES ON PROGRAMS.GENRE_ID = GENRES.CODE ORDER BY GENRES.LABEL ASC;

DROP VIEW "CHANNELS_WITH_VIDEO";
CREATE VIEW IF NOT EXISTS "CHANNELS_WITH_VIDEO" AS SELECT DISTINCT CHANNELS._id, CHANNELS.LABEL, CHANNELS.CHANNEL_ID, CHANNELS.VIDEO_REF_ID, CHANNELS.MOBILE, CHANNELS.LANGUAGE_ID, VIDEOS.GEO_BLOCKING_ORD FROM CHANNELS INNER JOIN VIDEOS ON CHANNELS.VIDEO_REF_ID = VIDEOS.REF_ID;
