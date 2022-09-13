pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;

with LeseEinheitenGebaut;

with TasteneingabeLogik;
with EinheitenmodifizierungLogik;
with StadtBauen;
with AufgabenLogik;
with EinheitenbewegungLogik;
with Kartenkoordinatenberechnungssystem;
with MausauswahlLogik;

package body EinheitenkontrollsystemLogik is

   procedure Einheitenkontrolle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
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
            return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           ÄnderungExtern           => Richtung (BefehlExtern));
               
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenmodifizierungLogik.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return True;
               
         when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | TastenbelegungDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => BefehlExtern,
                                              KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
               
         when TastenbelegungDatentypen.Bauen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Da das der Standardrückgabewert ist muss hier True zurückgegeben werden, da sonst die Schleife direkt nach der Auswahl wieder verlassen wird!
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end EinheitBefehle;
   
   
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Mausbefehl := MausauswahlLogik.Einheitenbefehle;
      
      case
        Mausbefehl
      is
         when BefehleDatentypen.Einheiten_Bewegung_Enum'Range =>
            return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           ÄnderungExtern          => Richtung (Mausbefehl));
            
         when BefehleDatentypen.Einheiten_Aufgaben_Enum'Range =>
            return EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   BefehlExtern             => Mausbefehl);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            return AllgemeineEinheitenbewegungMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            return False;
      end case;
                              
   end BefehleMaus;
   
   
   
   function AllgemeineEinheitenbewegungMaus
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
                  return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 ÄnderungExtern           => (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                        
               else
                  null;
               end if;
               
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
      end loop EÄnderungSchleife;
      
      return False;
      
   end AllgemeineEinheitenbewegungMaus;

end EinheitenkontrollsystemLogik;
