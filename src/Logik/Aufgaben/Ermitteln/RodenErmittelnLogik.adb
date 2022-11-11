with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseWeltkarte;
  
with Fehler;
with ArbeitszeitRodenLogik;
with Grenzpruefungen;

package body RodenErmittelnLogik is

   function RodenErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitRodenLogik.Basiszeit (EinheitRasseNummerExtern.Rasse, Gesamtgrund.Basisgrund)
      is
         when EinheitenKonstanten.UnmöglicheArbeit =>
            return False;
         
         when others =>
            null;
      end case;
      
      case
        Gesamtgrund.Basisgrund
      is
         when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             GrundExtern => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                GrundExtern => Gesamtgrund);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Roden_Trockenlegen_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "RodenErmitteln.RodenErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
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
      
   end RodenErmitteln;
   
   
   
   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitRodenLogik.Basiszeit (RasseExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitRodenLogik.Zusatzzeit (RasseExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (
              Aufgabe     => AufgabenDatentypen.Roden_Trockenlegen_Enum,
              Arbeitszeit => Arbeitszeit
             );
      
   end OberflächeLand;
   
     
     
   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitRodenLogik.Basiszeit (RasseExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                        ÄnderungExtern      => ArbeitszeitRodenLogik.Zusatzzeit (RasseExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (
              Aufgabe     => AufgabenDatentypen.Roden_Trockenlegen_Enum,
              Arbeitszeit => Arbeitszeit
             );
   
   end UnterflächeWasser;

end RodenErmittelnLogik;
