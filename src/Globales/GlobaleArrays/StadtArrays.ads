with StadtDatentypen;

-- Da ja nur der Datentyp am Ende relevant ist, könnte man auch alle 'Range Variante der Datentypen innen drin hier reinschieben. äöü
package StadtArrays is
   pragma Pure;

   type GebäudeArray is array (StadtDatentypen.GebäudeID'Range) of Boolean;

end StadtArrays;
