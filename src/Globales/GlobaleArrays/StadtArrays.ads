with StadtDatentypen;
package StadtArrays is
   pragma Pure;

   type GebäudeArray is array (StadtDatentypen.GebäudeIDVorhanden'Range) of Boolean;

end StadtArrays;
