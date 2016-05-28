CREATE TABLE `fei`.`new_table8` (
  `id` INT NULL AUTO_INCREMENT,
  `tv_name` VARCHAR(200) NULL,
  `tv_iconUrl` VARCHAR(200) NULL,
  `tv_downType` VARCHAR(200) NULL,
  `tv_downSeries` VARCHAR(200) NULL,
  `tv_downSeries_url` VARCHAR(200) NULL,
  PRIMARY KEY (`id`));


----------------------------------
连载中：75
已完结：2587

共计：2662



实际上:在已完结的后面几个分页，点击已经没有数据了，so,,,
连载中：75
已完结：2520

共计：2595
----------------------------------

select count(1) from fei.DBURL;
-- 18423
select count(distinct tv_name) from fei.dburl
-- 2591
