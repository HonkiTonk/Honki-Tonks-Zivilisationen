with EinheitenDatentypen;
with SpeziesKonstanten;

with LeseEinheitenGebaut;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with DiplomatischerZustandLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with EinheitentransporterLogik;
with BewegungspunkteBerechnenLogik;
with TransporterBeladenEntladenLogik;

package body EinheitenbewegungLogik is
   
   function BewegungPrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
            
      FeldPassierbar := PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                  NeueKoordinatenExtern      => KoordinatenExtern);
      EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                LogikGrafikExtern => True);
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Nummer = EinheitenKonstanten.LeerNummer
      then
         return False;
         
      elsif
        EinheitAufFeld.Spezies = EinheitSpeziesNummerExtern.Spezies
        and
          KoordinatenExtern = Zielkoordinaten
      then
         return Einheitentausch (BewegendeEinheitExtern => EinheitSpeziesNummerExtern,
                                 StehendeEinheitExtern  => EinheitAufFeld);
         
      elsif
        EinheitAufFeld.Spezies = EinheitSpeziesNummerExtern.Spezies
        and
          KoordinatenExtern /= Zielkoordinaten
      then
         return False;
         
      elsif
        FeldPassierbar = False
      then
         return False;
         
      else
         StadtAufFeld := StadtSuchenLogik.KoordinatenStadtOhneSpezielleSpeziesSuchen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                                                      KoordinatenExtern => KoordinatenExtern);
      end if;
         
      if
        (EinheitAufFeld.Spezies /= EinheitSpeziesNummerExtern.Spezies
         and
           EinheitAufFeld.Spezies /= SpeziesKonstanten.LeerSpezies)
        or
          (StadtAufFeld.Spezies /= SpeziesKonstanten.LeerSpezies
           and
             StadtAufFeld.Spezies /= EinheitSpeziesNummerExtern.Spezies)
      then
         if
           KoordinatenExtern /= Zielkoordinaten
         then
            return False;
               
         else
            return True;
         end if;
         
      else
         return True;
      end if;
      
   end BewegungPrüfen;
   
   
   
   function FremderAufFeld
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FremdeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
            
      case
        DiplomatischerZustandLogik.GegnerAngreifen (EigeneSpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                    GegnerischeSpeziesExtern => FremdeEinheitExtern.Spezies)
      is
         when False =>
            return False;
            
         when True =>
            return KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern   => EinheitSpeziesNummerExtern,
                                                                  VerteidigerExtern => FremdeEinheitExtern);
      end case;
      
   end FremderAufFeld;
   
   
   
   function FremdeStadtAufFeld
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FremdeStadtExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      case
        DiplomatischerZustandLogik.GegnerAngreifen (EigeneSpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                    GegnerischeSpeziesExtern => FremdeStadtExtern.Spezies)
      is
         when True =>
            return KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           VerteidigendeStadtSpeziesNummerExtern => FremdeStadtExtern);
            
         when False =>
            return False;
      end case;
      
   end FremdeStadtAufFeld;
   
   
   
   function Einheitentausch
     (BewegendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => BewegendeEinheitExtern,
                                                                  TransporterExtern => StehendeEinheitExtern)
        and then
          True = TransporterBeladenEntladenLogik.IstTransporterBeladbar (TransporterExtern => StehendeEinheitExtern)
      then
         return True;
         
      else
         return EinheitentauschPrüfung (BewegendeEinheitExtern => BewegendeEinheitExtern,
                                         StehendeEinheitExtern  => StehendeEinheitExtern);
      end if;
      
   end Einheitentausch;
   
   
   
   function EinheitentauschPrüfung
     (BewegendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => BewegendeEinheitExtern,
                                                           TransporterExtern => StehendeEinheitExtern)
      is
         when True =>
            return True;
         
         when False =>
            return NurTauschen (BewegendeEinheitExtern => BewegendeEinheitExtern,
                                StehendeEinheitExtern  => StehendeEinheitExtern);
      end case;
      
   end EinheitentauschPrüfung;
      
   
   
   function NurTauschen
     (BewegendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      BewegendeKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => BewegendeEinheitExtern);
      StehendeKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => StehendeEinheitExtern);
      
      if
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => StehendeEinheitExtern,
                                                                          NeueKoordinatenExtern      => BewegendeKoordinaten)
        or
          False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => BewegendeEinheitExtern,
                                                                            NeueKoordinatenExtern      => StehendeKoordinaten)
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => StehendeEinheitExtern) < BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern      => BewegendeKoordinaten,
                                                                                                                                                             EinheitSpeziesNummerExtern => StehendeEinheitExtern)
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => BewegendeEinheitExtern) < BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern      => StehendeKoordinaten,
                                                                                                                                                                EinheitSpeziesNummerExtern => BewegendeEinheitExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end NurTauschen;
     
end EinheitenbewegungLogik;
