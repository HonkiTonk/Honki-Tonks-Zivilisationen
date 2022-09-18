pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with BewegungsberechnungLogik;
with DiplomatischerZustandLogik;
with LadungsbewegungLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with EinheitentransporterLogik;
with KartenkoordinatenberechnungssystemLogik;

package body EinheitenbewegungLogik is
   
   -- Hier wird True zurückgegeben wenn keine Bewegung stattfindet, damit klar ist dass noch eine weitere Bewegung stattfinden kann.
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      NeuePosition := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                             ÄnderungExtern    => PositionÄnderungExtern,
                                                                                             LogikGrafikExtern => True);
      
      case
        NeuePosition.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
            
         when others =>
            null;
      end case;
      
      FeldPassierbar := PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                  NeueKoordinatenExtern       => NeuePosition);
      
      EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePosition,
                                                                              LogikGrafikExtern => True);
      StadtAufFeld := StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                 KoordinatenExtern => NeuePosition);
      BewegungDurchführen := False;
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Nummer = EinheitenKonstanten.LeerNummer
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          False = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                                     TransporterExtern => EinheitAufFeld)
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                                    TransporterExtern => EinheitAufFeld)
      then
         EigeneEinheitAufFeld (BewegendeEinheitExtern     => EinheitRasseNummerExtern,
                               FeldBelegendeEinheitExtern => EinheitAufFeld);
         
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
      then
         if
           FeldPassierbar
           and
             (True = FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     FremdeEinheitExtern      => EinheitAufFeld))
         then
            BewegungDurchführen := True;
            
         else
            null;
         end if;
         
      elsif
        StadtAufFeld.Nummer /= StadtKonstanten.LeerNummer
        and
          FeldPassierbar
      then
         case
           FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               FremdeStadtExtern        => StadtAufFeld)
         is
            when False =>
               null;
               
            when True =>
               BewegungDurchführen := True;
         end case;
         
      else
         BewegungDurchführen := True;
      end if;
      
      case
        BewegungDurchführen
      is
         when True =>
            BewegungsberechnungLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          NeueKoordinatenExtern    => NeuePosition);
            
         when False =>
            null;
      end case;
      
      return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungPrüfen;
   
   
   
   -- Wird auch in KIEinheitHandlungen verwendet.
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
        or
          LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
      then
         return False;
            
      else
         return True;
      end if;
      
   end NochBewegungspunkte;
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      case
        DiplomatischerZustandLogik.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                                    GegnerischeRasseExtern => FremdeEinheitExtern.Rasse)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        True = KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
                                                              VerteidigerExtern => FremdeEinheitExtern)
      then
         case
           EinheitAufFeld.Nummer
         is
            when EinheitenKonstanten.LeerNummer =>
               return True;
                     
            when others =>
               null;
         end case;
         
      else
         null;
      end if;
      
      return False;
      
   end FremderAufFeld;
   
   
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        DiplomatischerZustandLogik.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                                    GegnerischeRasseExtern => FremdeStadtExtern.Rasse)
      is
         when True =>
            return KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           VerteidigendeStadtRasseNummerExtern => FremdeStadtExtern);
            
         when False =>
            return False;
      end case;
      
   end FremdeStadtAufFeld;
   
   
   
   -- Hier vielleicht später mehr einbauen? Beispielsweise Plätzetauschen? äöü
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeldBelegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      LadungsbewegungLogik.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                               LadungExtern      => BewegendeEinheitExtern.Nummer);
      
   end EigeneEinheitAufFeld;
   
   
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      if
        ÄnderungExtern = KeineÄnderung
      then
         return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      else
         return BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 PositionÄnderungExtern   => ÄnderungExtern);
      end if;
      
   end PositionÄndern;

end EinheitenbewegungLogik;
