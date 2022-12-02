with LeseEinheitenGebaut;
with LeseCursor;

with TasteneingabeLogik;
with EinheitenmodifizierungLogik;
with StadtBauenLogik;
with AufgabenLogik;
with MausauswahlLogik;
with PZBEingesetztLogik;
with EinheitentransporterLogik;
with NachGrafiktask;
with EinheitenbewegungsbereichLogik;

with BewegungsplanLogik;

package body EinheitenkontrollsystemLogik is

   procedure Einheitenkontrolle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Bewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      EinheitenbewegungsbereichLogik.BewegungsbereichBerechnen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      NachGrafiktask.EinheitBewegungsbereich := True;
      
      KontrollSchleife:
      loop
         
         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => TasteneingabeLogik.Einheitentaste)
         is
            when True =>
               if
                 Bewegungspunkte = LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
               then
                  null;
                  
               else
                  Bewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  EinheitenbewegungsbereichLogik.BewegungsbereichBerechnen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               end if;
               
            when False =>
               exit KontrollSchleife;
         end case;
         
      end loop KontrollSchleife;
      
      NachGrafiktask.EinheitBewegungsbereich := False;
      
   end Einheitenkontrolle;
   
   
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Enum)
      return Boolean
   is begin
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Auswählen_Enum =>
            return BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when BefehleDatentypen.Einheiten_Bewegung_Enum'Range =>
            NachGrafiktask.EinheitBewegt := True;
            return BewegungsplanLogik.Einzelschritt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     ÄnderungExtern           =>  Richtung (BefehlExtern));
            
         when BefehleDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenmodifizierungLogik.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return True;
            
         when BefehleDatentypen.Entladen_Enum =>
            EinheitentransporterLogik.TransporterEntladen (TransporterExtern => EinheitRasseNummerExtern);
            return True;
               
         when BefehleDatentypen.Siedler_Verbesserung_Enum'Range | BefehleDatentypen.Einheiten_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => BefehlExtern,
                                              KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
               
         when BefehleDatentypen.Bauen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauenLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Da das der Standardrückgabewert ist muss hier True zurückgegeben werden, da sonst die Schleife direkt nach der Auswahl wieder verlassen wird!
         when BefehleDatentypen.Leer_Einheitenbelegung_Enum =>
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
            return BewegungsplanLogik.Einzelschritt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     ÄnderungExtern           =>  Richtung (Mausbefehl));
            
         when BefehleDatentypen.Einheiten_Aufgaben_Enum'Range =>
            if
              PZBEingesetztLogik.PZBEingesetzt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return False;
              
            else
               return EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      BefehlExtern             => Mausbefehl);
            end if;
            
         when BefehleDatentypen.Auswählen_Enum =>
            return BewegungsplanLogik.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      ZielkoordinatenExtern    => LeseCursor.KoordinatenAktuell (RasseExtern => EinheitRasseNummerExtern.Rasse));
            
         when others =>
            return False;
      end case;
                              
   end BefehleMaus;

end EinheitenkontrollsystemLogik;
