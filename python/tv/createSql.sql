CREATE TABLE `fei`.`new_table8` (
  `id` INT NULL AUTO_INCREMENT,
  `tv_name` VARCHAR(200) NULL,
  `tv_iconUrl` VARCHAR(200) NULL,
  `tv_downType` VARCHAR(200) NULL,
  `tv_downSeries` VARCHAR(200) NULL,
  `tv_downSeries_url` VARCHAR(200) NULL,
  PRIMARY KEY (`id`));









SELECT count(*) FROM fei.DBURL where  tv_downSeries_url is not null or tv_downSeries_url<>'';

SELECT * FROM fei.DBURL where  tv_downSeries_url = ''

SELECT * FROM fei.DBURL where  tv_downSeries_url = ''

SELECT count(*) FROM fei.DBURL where tv_downSeries_url != '';
SELECT  count(1)  FROM fei.DBURL   ;
SELECT  *  FROM fei.DBURL   ;




