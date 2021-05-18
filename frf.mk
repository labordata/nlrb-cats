FRF_YEARS =2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010

.INTERMEDIATE : $(patsubst %,%_CATS-FRF-R.final.csv,$(FRF_YEARS))
CATS-FRF-R.final.csv : $(patsubst %,%_CATS-FRF-R.final.csv,$(FRF_YEARS))
	csvstack $^ > $@

%_CATS-FRF-R.final.xml : raw/CATS-FRF-R-%.final.zip
	unzip -p $< CATS-FRF-R-$$(( $* - 1)).final.xml > $@
