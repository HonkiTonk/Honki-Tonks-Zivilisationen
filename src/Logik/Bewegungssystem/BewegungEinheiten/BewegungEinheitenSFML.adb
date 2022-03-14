pragma SPARK_Mode (On);

with Sf;

with KartenKonstanten;

with LeseEinheitenGebaut;

with Eingabe;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with BewegungEinheiten;
with GrafikEinstellungenSFML;
with BerechnungenKarteSFML;
with KarteKoordinatenPruefen;
with BewegungCursor;

-- Das hier mal umbenennen, man kann hier ja inzwischen wesentlich mehr machen als nur die Einheit bewegen.
package body BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Änderung := KeineÄnderung;
      
      BewegenSchleife:
      loop
         
         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => Eingabe.Tastenwert)
         is
            when True =>
               null;
               
            when False =>
               return;
         end case;
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   
   
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return Boolean
   is begin
            
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            Änderung := Richtung (BefehlExtern);
               
         when TastenbelegungKonstanten.HeimatstadtÄndernKonstante =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | TastenbelegungDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BefehlExtern             => BefehlExtern);
               
         when TastenbelegungKonstanten.BauenKonstante =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when TastenbelegungKonstanten.LeerTastenbelegungKonstante =>
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
         null;
      end if;
      
      return PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             ÄnderungExtern           => Änderung);
      
   end EinheitBefehle;
   
   
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausPosition := GrafikEinstellungenSFML.MausPosition;
      
      MausSchleife:
      loop
         
         if
           MausPosition.x in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x)
           and
             MausPosition.y in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y)
         then
            return MausInKarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           MausPosition.x in Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x) .. Sf.sfInt32 (BerechnungenKarteSFML.FensterAnzeige.x)
           and
             MausPosition.y in Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y) .. Sf.sfInt32 (BerechnungenKarteSFML.FensterAnzeige.y)
         then
            return MausInAnzeige (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            -- Die Schleife entfernen und immer True zurückgeben, wenn der Mauszeiger außerhalb des Fensters ist?
            null;
         end if;
         
      end loop MausSchleife;
      
   end BefehleMaus;
   
   
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      EingabeSchleife:
      loop
         
         BefehlMaus := Eingabe.Tastenwert;
         
         case
           BefehlMaus
         is
            when TastenbelegungKonstanten.MenüZurückKonstante =>
               return False;
               
            when TastenbelegungKonstanten.EbeneHochKonstante =>
               BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                      RichtungExtern => BefehlMaus,
                                                      RasseExtern    => EinheitRasseNummerExtern.Rasse);
               
            when TastenbelegungKonstanten.EbeneRunterKonstante =>
               BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                      RichtungExtern => BefehlMaus,
                                                      RasseExtern    => EinheitRasseNummerExtern.Rasse);
               
            when TastenbelegungKonstanten.AuswählenKonstante =>
               return EinheitBewegenMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when TastenbelegungKonstanten.LeerTastenbelegungKonstante =>
               null;
               
            when others =>
               return EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      BefehlExtern             => BefehlMaus);
         end case;
         
      end loop EingabeSchleife;
      
   end MausInKarte;
   
   
   
   function EinheitBewegenMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      EÄnderungSchleife:
      for EÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                                          
               KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                              ÄnderungExtern    => (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                              LogikGrafikExtern => True);
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
                 KartenWert = GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Koordinaten
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
