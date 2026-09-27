with SystemDatentypenHTSEB;

package LadezeitenAllgemeinesLogik is
   pragma Elaborate_Body;

   function ZeiteinheitBerechnen
     return SystemDatentypenHTSEB.LadezeitBasis
     with
       Post => (
                 ZeiteinheitBerechnen'Result in SystemDatentypenHTSEB.LadezeitBasis'Range
              );

   function ZeiteinheitPlanetBerechnen
     return SystemDatentypenHTSEB.LadezeitBasis
     with
       Post => (
                 ZeiteinheitPlanetBerechnen'Result in SystemDatentypenHTSEB.LadezeitBasis'Range
              );

end LadezeitenAllgemeinesLogik;
