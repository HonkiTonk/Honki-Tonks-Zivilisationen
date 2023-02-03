with LeseEinheitenGebaut;
with LeseCursor;
with LeseEinheitenDatenbank;

with TasteneingabeLogik;
with EinheitenmodifizierungLogik;
with StadtBauenLogik;
with AufgabenLogik;
with MausauswahlLogik;
with EinheitentransporterLogik;
with NachGrafiktask;
with EinheitenbewegungsbereichLogik;
with EffektberechnungenLogik;
with BewegungsplanLogik;

package body EinheitenkontrollsystemLogik is

   procedure Einheitenkontrolle
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Bewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      EinheitenbewegungsbereichLogik.BewegungsbereichBerechnen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      NachGrafiktask.EinheitBewegungsbereich := True;
      
      KontrollSchleife:
      loop
         
         case
           EinheitBefehle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                           BefehlExtern               => TasteneingabeLogik.Einheitentaste)
         is
            when True =>
               NeueBewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
               if
                 Bewegungspunkte = NeueBewegungspunkte
               then
                  null;
                  
               elsif
                 NeueBewegungspunkte = 0
               then
                  exit KontrollSchleife;
                  
               else
                  Bewegungspunkte := NeueBewegungspunkte;
                  EinheitenbewegungsbereichLogik.BewegungsbereichBerechnen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               end if;
               
            when False =>
               exit KontrollSchleife;
         end case;
         
      end loop KontrollSchleife;
      
      NachGrafiktask.EinheitBewegungsbereich := False;
      
   end Einheitenkontrolle;
   
   
   
   function EinheitBefehle
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Enum)
      return Boolean
   is begin
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Auswählen_Enum =>
            return BefehleMaus (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when BefehleDatentypen.Einheiten_Bewegung_Enum'Range =>
            NachGrafiktask.EinheitBewegt := True;
            return BewegungsplanLogik.Einzelschritt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     ÄnderungExtern             =>  Richtung (BefehlExtern));
            
         when BefehleDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenmodifizierungLogik.HeimatstadtÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            return True;
            
         when BefehleDatentypen.Entladen_Enum =>
            EinheitentransporterLogik.TransporterEntladen (TransporterExtern => EinheitSpeziesNummerExtern);
            return True;
               
         when BefehleDatentypen.Siedler_Verbesserung_Enum'Range | BefehleDatentypen.Einheiten_Allgemeine_Befehle_Enum'Range | BefehleDatentypen.Feldeffekte_Entfernen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              BefehlExtern               => BefehlExtern,
                                              AnlegenTestenExtern        => True,
                                              KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
               
         when BefehleDatentypen.Bauen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauenLogik.StadtBauen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
            -- Da das der Standardrückgabewert ist muss hier True zurückgegeben werden, da sonst die Schleife direkt nach der Auswahl wieder verlassen wird!
         when BefehleDatentypen.Leer_Einheitenbelegung_Enum =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end EinheitBefehle;
   
   
   
   function BefehleMaus
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Einheitart_Enum;
   begin
      
      Mausbefehl := MausauswahlLogik.Einheitenbefehle;
      
      case
        Mausbefehl
      is
         when BefehleDatentypen.Einheiten_Bewegung_Enum'Range =>
            return BewegungsplanLogik.Einzelschritt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     ÄnderungExtern             =>  Richtung (Mausbefehl));
            
         when BefehleDatentypen.Einheiten_Aufgaben_Enum'Range =>
            if
              EinheitenDatentypen.Einmalig_Enum = LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                       IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
            then
               EffektberechnungenLogik.Effektberechnungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               return False;
              
            else
               return EinheitBefehle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                      BefehlExtern               => Mausbefehl);
            end if;
            
         when BefehleDatentypen.Auswählen_Enum =>
            return BewegungsplanLogik.BewegungPlanen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                      ZielkoordinatenExtern      => LeseCursor.KoordinatenAktuell (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
            
         when others =>
            return False;
      end case;
                              
   end BefehleMaus;

end EinheitenkontrollsystemLogik;
