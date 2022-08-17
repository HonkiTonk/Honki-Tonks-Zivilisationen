pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with TextaccessVariablen;
with TextKonstanten;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with TextberechnungenHoeheSFML;

package body AllgemeineTextanzeigeSFML is

   procedure Überschrift
   is begin
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ÜberschriftAccess);
      
   end Überschrift;
   
   
   
   function Versionsnummer
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleTextpositionExtern : in Sf.System.Vector2.sfVector2f)
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Rückgabewert.x := AktuelleTextpositionExtern.x;
      Rückgabewert.y := AktuelleTextpositionExtern.y  + TextberechnungenHoeheSFML.Zeilenabstand;
      
      if
        ViewflächeExtern.y > Rückgabewert.y
      then
         PositionVersionsnummer.y := ViewflächeExtern.y - TextKonstanten.TexthöheZusatzwert - Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.VersionsnummerAccess).height;

      else
         PositionVersionsnummer.y := Rückgabewert.y;
      end if;

      PositionVersionsnummer.x := ViewflächeExtern.x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.VersionsnummerAccess);

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.VersionsnummerAccess,
                                    position => PositionVersionsnummer);
      
      NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.VersionsnummerAccess).width;

      if
        NeueTextbreite > Rückgabewert.x
      then
         Rückgabewert.x := NeueTextbreite;

      else
         null;
      end if;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.VersionsnummerAccess);
      
      Rückgabewert.y := Rückgabewert.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      return Rückgabewert;
      
   end Versionsnummer;

end AllgemeineTextanzeigeSFML;
