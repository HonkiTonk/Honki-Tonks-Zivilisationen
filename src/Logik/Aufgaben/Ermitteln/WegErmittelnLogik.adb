with EinheitenRecordKonstanten;

with LeseWeltkarte;
with LeseForschungenDatenbank;

with Fehlermeldungssystem;
with Grenzpruefungen;
with ForschungstestsLogik;
with ArbeitszeitWegLogik;
with AufgabeFestlegenLogik;

package body WegErmittelnLogik is
   
   function WegErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitWegLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, Gesamtgrund.Basisgrund)
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
            Arbeitswerte := OberflächeLand (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             WegExtern     => WegVorhanden,
                                             GrundExtern   => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
            Arbeitswerte := OberflächeWasser (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                               WegExtern     => WegVorhanden,
                                               GrundExtern   => Gesamtgrund);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                              WegExtern     => WegVorhanden,
                                              GrundExtern   => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                WegExtern     => WegVorhanden,
                                                GrundExtern   => Gesamtgrund);
               
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "WegErmittelnLogik.WegErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            AufgabeFestlegenLogik.AufgabeFestlegen (ArbeitExtern               => (Arbeitswerte.Aufgabe, Arbeitswerte.Arbeitszeit, False),
                                                    EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WegErmitteln;
   
   
   
   function OberflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
            
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern     => WelcheWegart (WegExtern),
                                                                                                                    SpeziesExtern => SpeziesExtern))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeLand;

   
     
   function OberflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      -- Eventuell noch Wege für andere Spezies auf Küstengewässer zulassen? äöü
      if
        GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
        and
          SpeziesExtern /= SpeziesDatentypen.Ekropa_Enum
      then
         return EinheitenRecordKonstanten.KeineArbeit;
         
      else
         null;
      end if;
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern     => WelcheWegart (KartenverbesserungDatentypen.Schiene_Einzeln_Enum),
                                                                                                                    SpeziesExtern => SpeziesExtern))
            then
               WelcheArbeit := WelcheWegart (KartenverbesserungDatentypen.Schiene_Einzeln_Enum);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum => -- KartenverbesserungDatentypen.Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern     => WelcheWegart (KartenverbesserungDatentypen.Tunnel_Einzeln_Enum),
                                                                                                                    SpeziesExtern => SpeziesExtern))
            then
               WelcheArbeit := WelcheWegart (KartenverbesserungDatentypen.Tunnel_Einzeln_Enum);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   -- Das ist doch ein wenig sinnfrei, oder? äöü
   function UnterflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Straße_Enum'Range | KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern     => WelcheWegart (WegExtern),
                                                                                                                    SpeziesExtern => SpeziesExtern))
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWegLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitWegLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return EinheitenRecordKonstanten.KeineArbeit;
      
      -- return (WelcheArbeit, Arbeitszeit);
   
   end UnterflächeWasser;

end WegErmittelnLogik;
