pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with GrafikEinstellungen;
with Sichtweiten;
with BerechnungenKarteSFML;
with KartePositionPruefen;

package body BewegungCursorSFML is
   
   procedure CursorPlatzierenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SichtbereichFestlegen (RasseExtern => RasseExtern);
                  
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in YSichtAnfang .. YSichtEnde loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in XSichtAnfang .. XSichtEnde loop
            
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
                     null;
                     
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
      
   end CursorPlatzierenSFML;
   
   
   
   procedure SichtbereichFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      YSichtAnfang := -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse;
      YSichtEnde := Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse;
      XSichtAnfang := -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse;
      XSichtEnde := Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse;
      
      YBereichSchleife:
      for YBereichSchleifenwert in YSichtAnfang .. YSichtEnde loop
         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                     ÄnderungExtern    => (0, YBereichSchleifenwert, 1));
         
         case
           KartenWert.YAchse
         is
            when KartenKonstanten.LeerYAchse =>
               if
                 YBereichSchleifenwert <= 0
               then
                  YSichtAnfang := YSichtAnfang + 1;
                  YSichtEnde := YSichtEnde + 1;
                  
               else
                  YSichtAnfang := YSichtAnfang - 1;
                  YSichtEnde := YSichtEnde - 1;
               end if;
                  
            when others =>
               null;
         end case;
         
      end loop YBereichSchleife;
      
      XBereichSchleife:
      for XBereichSchleifenwert in YSichtAnfang .. YSichtEnde loop
         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                     ÄnderungExtern    => (0, 1, XBereichSchleifenwert));
         
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               if
                 XBereichSchleifenwert <= 0
               then
                  XSichtAnfang := XSichtAnfang + 1;
                  XSichtEnde := XSichtEnde + 1;
                  
               else
                  XSichtAnfang := XSichtAnfang - 1;
                  XSichtEnde := XSichtEnde - 1;
               end if;
                  
            when others =>
               null;
         end case;
         
      end loop XBereichSchleife;
      
   end SichtbereichFestlegen;

end BewegungCursorSFML;
