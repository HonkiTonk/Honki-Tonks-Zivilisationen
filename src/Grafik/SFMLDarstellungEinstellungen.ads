pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;

package SFMLDarstellungEinstellungen is
   
   KritischesProblem : Boolean := False;

   ErzeugeFenster : Boolean := False;
   FensterErzeugt : Boolean := False;
   
   AktuelleDarstellung : SystemDatentypen.SFML_Aktuelle_Darstellung_Enum := SystemDatentypen.SFML_Start;
   
   TextZugriffAnzeige : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   -- Minimal möglicher Wert: 0.000000002 
   Wartezeit : constant Duration := 0.00002;

end SFMLDarstellungEinstellungen;
