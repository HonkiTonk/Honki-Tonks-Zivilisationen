with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with BewegungsberechnungEinheitenLogik;
with DiplomatischerZustandLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with EinheitentransporterLogik;
with KartenkoordinatenberechnungssystemLogik;
with BewegungspunkteBerechnenLogik;
with TransporterBeladenEntladenLogik;

package body EinheitenbewegungLogik is
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      if
        ÄnderungExtern = KeineÄnderung
      then
         return NochBewegungspunkte (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                     BewegungDurchführenExtern => False,
                                     KoordinatenExtern         => KartenRecordKonstanten.LeerKoordinate);
            
      else
         return BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 PositionÄnderungExtern   => ÄnderungExtern);
      end if;
      
   end PositionÄndern;
   
   
   
   -- Wird auch in KIEinheitHandlungen verwendet, eventuell in zwei Varianten aufteilen bei der nur eine Variante die BewegungsberechnungEinheitenLogik enthält? äöü
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BewegungDurchführenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        BewegungDurchführenExtern
      is
         when True =>
            BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern    => KoordinatenExtern,
                                                                   EinheitentauschExtern    => False);
            
         when False =>
            null;
      end case;
      
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
   
   
   
   -- Hier wird True zurückgegeben wenn keine Bewegung stattfindet, damit klar ist dass noch eine weitere Bewegung stattfinden kann.
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is begin
      
      NeueKoordinaten := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                     ÄnderungExtern    => PositionÄnderungExtern,
                                                                                                     LogikGrafikExtern => True);
      
      case
        NeueKoordinaten.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
            
         when others =>
            FeldPassierbar := PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                        NeueKoordinatenExtern    => NeueKoordinaten);
            EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinaten,
                                                                                    LogikGrafikExtern => True);
      end case;
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Nummer = EinheitenKonstanten.LeerNummer
      then
         return True;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
      then
         BewegungDurchführen := Einheitentausch (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                                  StehendeEinheitExtern  => EinheitAufFeld);
         
         return NochBewegungspunkte (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                     BewegungDurchführenExtern => BewegungDurchführen,
                                     KoordinatenExtern         => NeueKoordinaten);
         
      elsif
        FeldPassierbar = False
      then
         return False;
         
      else
         StadtAufFeld := StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                    KoordinatenExtern => NeueKoordinaten);
      end if;
         
      if
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
          and
            StadtAufFeld.Nummer /= StadtKonstanten.LeerNummer
      then
         case
           FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           FremdeEinheitExtern      => EinheitAufFeld)
         is
            when False =>
               return False;
               
            when True =>
               BewegungDurchführen := FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           FremdeStadtExtern        => StadtAufFeld);
         end case;
            
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
      then
         BewegungDurchführen := FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 FremdeEinheitExtern      => EinheitAufFeld);
      
      elsif
        StadtAufFeld.Nummer /= StadtKonstanten.LeerNummer
      then
         BewegungDurchführen := FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     FremdeStadtExtern        => StadtAufFeld);
         
      else
         BewegungDurchführen := True;
      end if;
      
      return NochBewegungspunkte (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                  BewegungDurchführenExtern => BewegungDurchführen,
                                  KoordinatenExtern         => NeueKoordinaten);
      
   end BewegungPrüfen;
   
   
   
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
            return KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
                                                                  VerteidigerExtern => FremdeEinheitExtern);
      end case;
      
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
   
   
   
   -- Das hier noch einmal überarbeiten, eventuell muss ich dazu auch die BewegungsberechnungLogik überarbeiten. äöü
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => BewegendeEinheitExtern,
                                                                  TransporterExtern => StehendeEinheitExtern)
        and then
          True = TransporterBeladenEntladenLogik.TransporterBeladen (TransporterExtern => StehendeEinheitExtern,
                                                                     LadungExtern      => BewegendeEinheitExtern.Nummer)
      then
         return False;
         
      else
         BewegendeKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => BewegendeEinheitExtern);
         StehendeKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => StehendeEinheitExtern);
      end if;
            
      if
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => StehendeEinheitExtern,
                                                                          NeueKoordinatenExtern    => BewegendeKoordinaten)
        or
          False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => BewegendeEinheitExtern,
                                                                            NeueKoordinatenExtern    => StehendeKoordinaten)
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => StehendeEinheitExtern) < BewegungspunkteBerechnenLogik.AbzugDurchBewegung (NeueKoordinatenExtern    => BewegendeKoordinaten,
                                                                                                                                                    EinheitRasseNummerExtern => StehendeEinheitExtern)
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => BewegendeEinheitExtern) < BewegungspunkteBerechnenLogik.AbzugDurchBewegung (NeueKoordinatenExtern    => StehendeKoordinaten,
                                                                                                                                                       EinheitRasseNummerExtern => BewegendeEinheitExtern)
      then
         return False;
         
      else
         BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => StehendeEinheitExtern,
                                                                NeueKoordinatenExtern    => BewegendeKoordinaten,
                                                                EinheitentauschExtern    => True);
      
         return True;
      end if;
      
   end Einheitentausch;

end EinheitenbewegungLogik;
