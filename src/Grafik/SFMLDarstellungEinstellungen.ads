pragma SPARK_Mode (On);

with SystemDatentypen;

package SFMLDarstellungEinstellungen is

   ErzeugeFenster : Boolean := False;
   FensterErzeugt : Boolean := False;
   
   AktuelleDarstellung : SystemDatentypen.SFML_Aktuelle_Darstellung_Enum := SystemDatentypen.SFML_Start;
   
   -- Minimal möglicher Wert: 0.000000002 
   Wartezeit : constant Duration := 0.0002;

end SFMLDarstellungEinstellungen;
