pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;

with KartenKonstanten;

with LeseEinheitenGebaut;

with EingabeSFML;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with BewegungEinheiten;
with NachLogiktask;
with BerechnungenKarteSFML;
with Kartenkoordinatenberechnungssystem;
with BewegungCursor;

-- Das hier mal umbenennen, man kann hier ja inzwischen wesentlich mehr machen als nur die Einheit bewegen.
package body BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Änderung := KeineÄnderung;
      
      BewegenSchleife:
      loop
         
         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => EingabeSFML.Tastenwert)
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
   
   
   
   -- Muss noch korrekt an das neue Viewsystem angepasst werden. äöü
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Mausposition := NachLogiktask.Mausposition;
      
      MausSchleife:
      loop
         
         if
           Mausposition.x in 0.00 .. BerechnungenKarteSFML.FensterKarte.x
           and
             Mausposition.y in 0.00 .. BerechnungenKarteSFML.FensterKarte.y
         then
            return MausInKarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           Mausposition.x in BerechnungenKarteSFML.FensterKarte.x .. BerechnungenKarteSFML.FensterAnzeige.x
           and
             Mausposition.y in BerechnungenKarteSFML.FensterKarte.y .. BerechnungenKarteSFML.FensterAnzeige.y
         then
            return MausInAnzeige (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            -- Die Schleife entfernen und immer True zurückgeben, wenn der Mauszeiger außerhalb des Fensters ist?
            null;
         end if;
         
      end loop MausSchleife;
      
   end BefehleMaus;
   
   
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      EingabeSchleife:
      loop
         
         BefehlMaus := EingabeSFML.Tastenwert;
         
         case
           BefehlMaus
         is
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return False;
               
            when TastenbelegungDatentypen.Ebene_Hoch_Enum =>
               BewegungCursor.CursorbewegungBerechnen (RichtungExtern => BefehlMaus,
                                                       RasseExtern    => EinheitRasseNummerExtern.Rasse);
               
            when TastenbelegungDatentypen.Ebene_Runter_Enum =>
               BewegungCursor.CursorbewegungBerechnen (RichtungExtern => BefehlMaus,
                                                       RasseExtern    => EinheitRasseNummerExtern.Rasse);
               
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
      
      EÄnderungSchleife:
      for EÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEinsEAchse'Range loop
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                                          
               KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
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
   
   
   
   function MausInAnzeige
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
      
   end MausInAnzeige;

end BewegungEinheitenSFML;
