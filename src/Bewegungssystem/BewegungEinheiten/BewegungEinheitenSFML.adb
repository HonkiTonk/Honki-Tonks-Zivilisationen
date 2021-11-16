pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;
with Sf;

with KartenDatentypen; use KartenDatentypen;
-- with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with KartenKonstanten;

with LeseEinheitenGebaut;

with Karte;
with KartePositionPruefen;
with Eingabe;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with Anzeige;
with BewegungCursorSFML;
with BewegungEinheiten;
with GrafikEinstellungen;
with BerechnungenKarteSFML;

package body BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

      BewegenSchleife:
      loop
         
         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
         is
            when SystemDatentypen.Oben =>
               Änderung := (0, -1, 0);
            
            when SystemDatentypen.Links =>
               Änderung := (0, 0, -1);
            
            when SystemDatentypen.Unten =>
               Änderung := (0, 1, 0);
            
            when SystemDatentypen.Rechts  =>
               Änderung := (0, 0, 1);
            
            when SystemDatentypen.Links_Oben =>
               Änderung := (0, -1, -1);
            
            when SystemDatentypen.Rechts_Oben =>
               Änderung := (0, -1, 1);
            
            when SystemDatentypen.Links_Unten =>
               Änderung := (0, 1, -1);

            when SystemDatentypen.Rechts_Unten =>
               Änderung := (0, 1, 1);
            
            when SystemDatentypen.Ebene_Hoch =>
               Änderung := (1, 0, 0);
            
            when SystemDatentypen.Ebene_Runter =>
               Änderung := (-1, 0, 0);
               
            when SystemDatentypen.Heimatstadt_Ändern =>
               EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
               
            when SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | SystemDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
               AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    BefehlExtern             => Befehl);
               
               case
                 AufgabeDurchführen
               is
                  when True =>
                     return;
               
                  when False =>
                     Änderung := KeineÄnderung;
                     Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                           TextZeileExtern => 2);
               end case;
               
            when SystemDatentypen.Bauen =>
               NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
               
            when SystemDatentypen.Mausbewegung =>
               if
                 BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
               then
                  null;
                  
               else
                  return;
               end if;
            
            when others =>
               return;
         end case;
         
         if
           Änderung = KeineÄnderung
         then
            BewegungNochMöglich := BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        ÄnderungExtern    => Änderung);
         
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  BewegungNochMöglich := True;
               
               when others =>
                  BewegungNochMöglich := BewegungEinheiten.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                             NeuePositionExtern       => KartenWert);
            end case;
         end if;
         
         case
           BewegungNochMöglich
         is
            when True =>
               null;
               
            when False =>
               return;
         end case;

         Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   
   
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      MausSchleife:
      loop
         
         if
           Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).x in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x)
           and
             Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).y in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y)
         then
            return MausInKarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).x in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterAnzeige.x)
           and
             Sf.Graphics.RenderWindow.Mouse.getPosition (relativeTo => GrafikEinstellungen.Fenster).y in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterAnzeige.y)
         then
            return MausInAnzeige (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            null;
         end if;
         
      end loop MausSchleife;
      
   end BefehleMaus;
   
   
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      Änderung := KeineÄnderung;
      
      EingabeSchleife:
      loop
         
         BefehlMaus := Eingabe.Tastenwert;
         
         case
           BefehlMaus
         is
            when SystemDatentypen.Menü_Zurück =>
               return False;
               
            when SystemDatentypen.Auswählen =>
               BewegungCursorSFML.CursorPlatzierenKarteSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
               
               YÄnderungSchleife:
               for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  XÄnderungSchleife:
                  for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
                     if
                       GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position.YAchse = LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern).YAchse + YÄnderungSchleifenwert
                       and
                         GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position.XAchse = LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse + XÄnderungSchleifenwert
                     then
                        Änderung := (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert);
                        return True;
                        
                     else
                        null;
                     end if;
                     
                  end loop XÄnderungSchleife;
               end loop YÄnderungSchleife;
               
            when others =>
               null;
         end case;
         
      end loop EingabeSchleife;
      
   end MausInKarte;
   
   
   
   function MausInAnzeige
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        EinheitRasseNummerExtern.Platznummer
      is
         when 1 =>
            null;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end MausInAnzeige;

end BewegungEinheitenSFML;
