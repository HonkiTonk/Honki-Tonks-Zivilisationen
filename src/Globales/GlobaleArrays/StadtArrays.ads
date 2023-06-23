with StadtDatentypen;
package StadtArrays is
   pragma Pure;

   type GebäudeArray is array (StadtDatentypen.GebäudeID'Range) of Boolean;

end StadtArrays;
