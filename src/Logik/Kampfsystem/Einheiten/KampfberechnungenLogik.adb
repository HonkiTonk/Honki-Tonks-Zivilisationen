with ZufallsgeneratorenKampfLogik;

package body KampfberechnungenLogik is

   -- Das direkt in den Zufallsgenerator schieben oder einzeln lassen um es später zu erweitern? äöü
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.KampfwerteGroß;
      VerteidigungExtern : in KampfDatentypen.KampfwerteGroß)
      return Integer
   is begin
      
      -- Man könnte hier noch was einbauen wenn einer der beiden Werte < 0 ist. äöü
      -- Müsste man wahrscheinlich eher im KampfsystemEinheiten/Stadt prüfen, auch ob alle Werte 0 sind. äöü
      ErfolgeAngreifer := ZufallsgeneratorenKampfLogik.ErreichteErfolge (WürfelanzahlExtern => AngriffExtern);
      ErfolgeVerteidiger := ZufallsgeneratorenKampfLogik.ErreichteErfolge (WürfelanzahlExtern => VerteidigungExtern);
      
      return ErfolgeAngreifer - ErfolgeVerteidiger;
      
   end Kampfberechnung;
   
end KampfberechnungenLogik;
