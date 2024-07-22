BEGIN;


CREATE TABLE staging."softcartDimDate"
(
    dateid integer NOT NULL,
    date date NOT NULL,
    quarter smallint NOT NULL,
    quartername character varying NOT NULL,
    month smallint NOT NULL,
    monthname character varying NOT NULL,
    day smallint NOT NULL,
    weekday smallint NOT NULL,
    weekdayname character varying NOT NULL,
    PRIMARY KEY (dateid)
);

CREATE TABLE staging."softcartDimCategory"
(
    categoryid integer NOT NULL,
    category character varying NOT NULL,
    PRIMARY KEY (categoryid)
);

CREATE TABLE staging."softcartDimItem"
(
    itemid integer NOT NULL,
    item character varying NOT NULL,
    PRIMARY KEY (itemid)
);

CREATE TABLE staging."softcartDimCountry"
(
    countryid integer NOT NULL,
    country character varying NOT NULL,
    PRIMARY KEY (countryid)
);

CREATE TABLE staging."softcartFactSales"
(
    orderid bigint NOT NULL,
    dateid integer NOT NULL,
    countryid integer NOT NULL,
    categoryid integer NOT NULL,
    itemid integer NOT NULL,
    price double precision NOT NULL,
    PRIMARY KEY (orderid)
);

ALTER TABLE staging."softcartFactSales"
    ADD FOREIGN KEY (dateid)
    REFERENCES staging."softcartDimDate" (dateid)
    NOT VALID;


ALTER TABLE staging."softcartFactSales"
    ADD FOREIGN KEY (countryid)
    REFERENCES staging."softcartDimCountry" (countryid)
    NOT VALID;


ALTER TABLE staging."softcartFactSales"
    ADD FOREIGN KEY (categoryid)
    REFERENCES staging."softcartDimCategory" (categoryid)
    NOT VALID;


ALTER TABLE staging."softcartFactSales"
    ADD FOREIGN KEY (itemid)
    REFERENCES staging."softcartDimItem" (itemid)
    NOT VALID;

END;