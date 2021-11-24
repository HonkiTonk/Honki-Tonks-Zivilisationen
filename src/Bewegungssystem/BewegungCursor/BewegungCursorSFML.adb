pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with GrafikEinstellungen;
with BerechnungenKarteSFML;
with KartePositionPruefen;

package body BewegungCursorSFML is
   
   procedure CursorPlatzierenKarteSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kommt es zu einem Absturz.
      MausPosition := GrafikEinstellungen.MausPosition;
      
      if
        MausPosition.y in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y)
        and
          MausPosition.x in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x)
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
              MausPosition.y
            in
              Sf.sfInt32 (YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y) .. Sf.sfInt32 (YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y + BerechnungenKarteSFML.KartenfelderAbmessung.y)
              and
                MausPosition.x
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
                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse := KartenWert.YAchse;
                     GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse := KartenWert.XAchse;
               end case;
               
               return;
               
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
