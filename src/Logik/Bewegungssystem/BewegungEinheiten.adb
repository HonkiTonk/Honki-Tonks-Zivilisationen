pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;

with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with BewegungBerechnen;
with DiplomatischerZustand;
with BewegungLadenEntladen;
with KampfsystemEinheiten;
with StadtSuchen;
with KampfsystemStadt;
with EinheitenTransporter;
with Kartenkoordinatenberechnungssystem;

package body BewegungEinheiten is
   
   -- Hier wird True zurückgegeben wenn keine Bewegung stattfindet, damit klar ist dass noch eine weitere Bewegung stattfinden kann.
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      NeuePosition := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
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
      
      FeldPassierbar := BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeueKoordinatenExtern       => NeuePosition);
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePosition,
                                                                         LogikGrafikExtern => True);
      StadtAufFeld := StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
          False = EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                                TransporterExtern => EinheitAufFeld)
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          True = EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
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
            BewegungBerechnen.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
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
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeEinheitExtern.Rasse)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        True = KampfsystemEinheiten.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
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
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeStadtExtern.Rasse)
      is
         when True =>
            return KampfsystemStadt.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
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
      
      BewegungLadenEntladen.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                                LadungExtern      => BewegendeEinheitExtern.Nummer);
      
   end EigeneEinheitAufFeld;

end BewegungEinheiten;