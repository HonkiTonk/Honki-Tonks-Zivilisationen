pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with LeseEinheitenGebaut;

with TasteneingabeLogik;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with BewegungEinheiten;
with Kartenkoordinatenberechnungssystem;
with Mausauswahl;

-- Das hier mal umbenennen, man kann hier ja inzwischen wesentlich mehr machen als nur die Einheit bewegen.
package body EinheitenkontrollsystemLogik is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Änderung := KeineÄnderung;
      
      BewegenSchleife:
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
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   
   
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return Boolean
   is begin
            
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            Änderung := Richtung (BefehlExtern);
               
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | TastenbelegungDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not Aufgaben.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => BefehlExtern,
                                         KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
               
         when TastenbelegungDatentypen.Bauen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            -- Statt nur bei Leer nichts machen und in allen anderen Fällen zurück oder nur bei Menü_Zurück zurück und sonst nicht?
            null;
            
         when others =>
            return False;
      end case;
      
      if
        Änderung = KeineÄnderung
      then
         return BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 ÄnderungExtern           => Änderung);
      end if;
            
   end EinheitBefehle;
   
   
   
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
            
      case
        Mausauswahl.Einheitenbewegung
      is
         when True =>
            return MausInKarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            return False;
      end case;
            
      -- return MausInBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
   end BefehleMaus;
   
   
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      EingabeSchleife:
      loop
         
         BefehlMaus := TasteneingabeLogik.Tastenwert;
         
         case
           BefehlMaus
         is
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return False;
               
            when TastenbelegungDatentypen.Ebene_Hoch_Enum | TastenbelegungDatentypen.Ebene_Runter_Enum =>
               return PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       ÄnderungExtern          => Richtung (BefehlMaus));
               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               return EinheitBewegenMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
               null;
               
            when others =>
               return EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      BefehlExtern             => BefehlMaus);
         end case;
         
      end loop EingabeSchleife;
      
   end MausInKarte;
   
   
   
   function EinheitBewegenMaus
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
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
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
      
   end EinheitBewegenMaus;
   
   
   
   function MausInBefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        EinheitRasseNummerExtern.Nummer
      is
         when 1 =>
            null;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end MausInBefehle;

end EinheitenkontrollsystemLogik;
