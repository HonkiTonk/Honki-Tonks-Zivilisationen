pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseEinheitenGebaut;

with TasteneingabeLogik;
with EinheitenModifizieren;
with StadtBauen;
with AufgabenLogik;
with BewegungEinheiten;
with Kartenkoordinatenberechnungssystem;
with MausauswahlLogik;

package body EinheitenkontrollsystemLogik is

   procedure Einheitenkontrolle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Änderung := KeineÄnderung;
      
      KontrollSchleife:
      loop
         
         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => TasteneingabeLogik.Tastenwert)
         is
            when True =>
               null;
               
            when False =>
               return;
         end case;
         
      end loop KontrollSchleife;
      
   end Einheitenkontrolle;
   
   
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return Boolean
   is begin
            
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Auswählen_Enum =>
            return BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            Änderung := Richtung (BefehlExtern);
               
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | TastenbelegungDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => BefehlExtern,
                                              KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
               
         when TastenbelegungDatentypen.Bauen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            -- Statt nur bei Leer nichts machen und in allen anderen Fällen zurück oder nur bei Menü_Zurück zurück und sonst nicht?
            null;
            
         when TastenbelegungDatentypen.Menü_Zurück_Enum =>
            return False;
            
         when others =>
            return False;
      end case;
      
      if
        Änderung = KeineÄnderung
      then
         return True;
      else
         return PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 ÄnderungExtern           => Änderung);
      end if;
            
   end EinheitBefehle;
   
   
   
   -- Das hier nach BewegungEinheit oder irgendeiner Bewegungsprüfung schieben? äöü
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      if
        ÄnderungExtern = KeineÄnderung
      then
         BewegungNochMöglich := BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      else
         BewegungNochMöglich := BewegungEinheiten.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    PositionÄnderungExtern   => ÄnderungExtern);
         Änderung := KeineÄnderung;
      end if;
      
      return BewegungNochMöglich;
      
   end PositionÄndern;
   
   
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Bewegung und dann eine Option für jeden gültigen Befehl. äöü
      Mausbefehl := MausauswahlLogik.Einheitenbefehle;
      
      case
        Mausbefehl
      is
         when BefehleDatentypen.Leer_Enum =>
            return False;
            
         when BefehleDatentypen.Weltkartenbefehle_Bewegung_Enum'Range =>
            return EinheitenbewegungMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when BefehleDatentypen.Weltkartenbefehle_Vorhanden_Enum'Range =>
            return EinheitenbefehlMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        BefehleExtern            => Mausbefehl);
      end case;
                              
   end BefehleMaus;
   
   
   
   function EinheitenbewegungMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      EÄnderungSchleife:
      for EÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEinsEAchse'Range loop
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                                          
               KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                    ÄnderungExtern    => (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                    LogikGrafikExtern => True);
               
               -- In diesem Fall wird die Prüfung auf Leer nicht benötigt, da im aktuellen System die Cursorkoordinaten niemals ungültig sein können.
               if
                 KartenWert = SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell
               then
                  Änderung := (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert);
                  
                  return PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                          ÄnderungExtern           => Änderung);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
      end loop EÄnderungSchleife;
      
      return False;
      
   end EinheitenbewegungMaus;
   
   
   
   function EinheitenbefehlMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehleExtern : in BefehleDatentypen.Weltkartenbefehle_Vorhanden_Enum)
      return Boolean
   is begin
            
      case
        EinheitRasseNummerExtern.Nummer
      is
         when 1 =>
            null;
            
         when others =>
            Platzhalter := BefehleExtern;
      end case;
      
      return True;
      
   end EinheitenbefehlMaus;

end EinheitenkontrollsystemLogik;
