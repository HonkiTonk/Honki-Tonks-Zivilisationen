pragma SPARK_Mode (On);

with GrafikEinstellungen;
with Fehler;

package body SFMLAllgemeinePruefungen is

   procedure PositionPrüfen
     (PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        PositionExtern.y < 0.00
        or
          PositionExtern.x < 0.00
          or
            PositionExtern.y > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)
        or
          PositionExtern.x > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite)
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "SFMLAllgemeinePruefungen.PositionPrüfen - Ein Objekt wurde außerhalb des vorgesehenen Bereichs positioniert.");
         
      else
         null;
      end if;
      
   end PositionPrüfen;

end SFMLAllgemeinePruefungen;
