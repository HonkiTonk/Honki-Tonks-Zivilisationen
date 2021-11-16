pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with GrafikEinstellungen;
with BerechnungenKarteSFML;
with KartePositionPruefen;

package body BewegungCursorSFML is
   
   procedure CursorPlatzierenKarteSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).y in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y)
        and
          Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).x in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x)
      then
         null;
         
      else
         return;
      end if;
      
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen (RasseExtern => RasseExtern);
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            if
              Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).y
            in
              Sf.sfInt32 (YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y) .. Sf.sfInt32 (YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y + BerechnungenKarteSFML.KartenfelderAbmessung.y)
              and
                Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).x
            in
              Sf.sfInt32 (XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x) .. Sf.sfInt32 (XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x + BerechnungenKarteSFML.KartenfelderAbmessung.x)
            then
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                           ÄnderungExtern   => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 KartenWert.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     return;
                     
                  when others =>
                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position := KartenWert;
                     return;
               end case;
               
            else
               XMultiplikator := XMultiplikator + 1.00;
            end if;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end CursorPlatzierenKarteSFML;
   
   
   
   procedure CursorPlatzierenStadtSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end CursorPlatzierenStadtSFML;

end BewegungCursorSFML;
