pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen; use KampfDatentypen;

with ZufallsgeneratorenKampfLogik;

package body KampfberechnungenLogik is

   -- Das direkt in den Zufallsgenerator schieben oder einzeln lassen um es später zu erweitern? äöü
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte)
      return Integer
   is begin
      
      ErfolgeAngreifer := ZufallsgeneratorenKampfLogik.ErreichteErfolge (WürfelanzahlExtern => AngriffExtern);
      ErfolgeVerteidiger := ZufallsgeneratorenKampfLogik.ErreichteErfolge (WürfelanzahlExtern => VerteidigungExtern);
      
      return ErfolgeAngreifer - ErfolgeVerteidiger;
      
   end Kampfberechnung;
   
end KampfberechnungenLogik;
