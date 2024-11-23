package body KampfberechnungenLogik is

   -- Das direkt in den Zufallsgenerator schieben oder einzeln lassen um es später zu erweitern? äöü
   -- Beim Kampf nur den Angriffswert gegen den Verteidigungswert stellen und entsprechend der Erfolge die Lebenspunkte abziehen? äöü
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte)
      return Integer
   is begin
      
      ErfolgeAngreifer := Kampferfolge (WürfelanzahlExtern => AngriffExtern);
      ErfolgeVerteidiger := Kampferfolge (WürfelanzahlExtern => VerteidigungExtern);
      
      return ErfolgeAngreifer - ErfolgeVerteidiger;
      
   end Kampfberechnung;
   
end KampfberechnungenLogik;
