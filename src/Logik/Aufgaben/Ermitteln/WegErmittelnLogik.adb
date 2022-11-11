with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseWeltkarte;
with LeseForschungenDatenbank;

with Fehler;
with Grenzpruefungen;
with ForschungstestsLogik;
with ArbeitszeitWegLogik;

package body WegErmittelnLogik is
   
   function WegErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitWegLogik.Basiszeit (EinheitRasseNummerExtern.Rasse, Gesamtgrund.Basisgrund)
      is
         when EinheitenKonstanten.UnmöglicheArbeit =>
            return False;
         
         when others =>
            WegVorhanden := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      end case;

      case
        Gesamtgrund.Basisgrund
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             WegExtern   => WegVorhanden,
                                             GrundExtern => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
            Arbeitswerte := OberflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                               WegExtern   => WegVorhanden,
                                               GrundExtern => Gesamtgrund);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                              WegExtern   => WegVorhanden,
                                              GrundExtern => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                WegExtern   => WegVorhanden,
                                                GrundExtern => Gesamtgrund);
               
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WegErmitteln.WegErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => Arbeitswerte.Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                         RechnenSetzenExtern      => False);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WegErmitteln;
   
   
   
   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
            
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern   => WelcheWegart (WegExtern),
                                                                                                                    RasseExtern => RasseExtern))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (RasseExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (RasseExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeLand;

   
     
   function OberflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      -- Eventuell noch Wege für andere Rassen auf Küstengewässer zulassen? äöü
      if
        GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
        and
          RasseExtern /= RassenDatentypen.Ekropa_Enum
      then
         return EinheitenRecordKonstanten.KeineArbeit;
         
      else
         null;
      end if;
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern   => WelcheWegart (KartenverbesserungDatentypen.Schiene_Einzeln_Enum),
                                                                                                                    RasseExtern => RasseExtern))
            then
               WelcheArbeit := WelcheWegart (KartenverbesserungDatentypen.Schiene_Einzeln_Enum);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (RasseExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (RasseExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum => -- KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern   => WelcheWegart (KartenverbesserungDatentypen.Tunnel_Einzeln_Enum),
                                                                                                                    RasseExtern => RasseExtern))
            then
               WelcheArbeit := WelcheWegart (KartenverbesserungDatentypen.Tunnel_Einzeln_Enum);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (RasseExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (RasseExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   -- Das ist doch ein wenig sinnfrei, oder? äöü
   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Karten_Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern   => WelcheWegart (WegExtern),
                                                                                                                    RasseExtern => RasseExtern))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (RasseExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (RasseExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return EinheitenRecordKonstanten.KeineArbeit;
      
      -- return (WelcheArbeit, Arbeitszeit);
   
   end UnterflächeWasser;

end WegErmittelnLogik;
