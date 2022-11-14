with EinheitenRecordKonstanten;
with TextnummernKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseWeltkarte;

with RodenErmittelnLogik;
with Fehler;
with JaNeinLogik;
with ArbeitszeitWaldLogik;
with Grenzpruefungen;

package body WaldErmittelnLogik is

   function WaldErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitWaldLogik.Basiszeit (EinheitRasseNummerExtern.Rasse, Gesamtgrund.Basisgrund)
      is
         when EinheitenKonstanten.UnmöglicheArbeit =>
            return False;
         
         when others =>
            VorhandeneVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      end case;
      
      if
        (VorhandeneVerbesserung = KartenverbesserungDatentypen.Farm_Enum
         or
           VorhandeneVerbesserung = KartenverbesserungDatentypen.Mine_Enum)
        and
          SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
      then
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungErsetzen)
         is
            when True =>
               null;
            
            when False =>
               return False;
         end case;

      else
         null;
      end if;
            
      case
        Gesamtgrund.Basisgrund
      is
         when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => Gesamtgrund,
                                             AnlegenTestenExtern      => AnlegenTestenExtern,
                                             KoordinatenExtern        => KoordinatenExtern);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                GrundExtern              => Gesamtgrund,
                                                AnlegenTestenExtern      => AnlegenTestenExtern,
                                                KoordinatenExtern        => KoordinatenExtern);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Wald_Aufforsten_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WaldErmitteln.WaldErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            if
              Arbeitswerte.Vorarbeit
            then
               SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BeschäftigungExtern     => Arbeitswerte.Aufgabe);
               SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                                      RechnenSetzenExtern      => False);
               
            else
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => Arbeitswerte.Aufgabe);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                            RechnenSetzenExtern      => False);
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WaldErmitteln;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWaldLogik.Basiszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.Basisgrund));
      
      if
        GrundExtern.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         VorarbeitNötig := False;
         
      elsif
        True = RodenErmittelnLogik.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWaldLogik.Zusatzzeit (EinheitRasseNummerExtern.Rasse, GrundExtern.Zusatzgrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Wald_Aufforsten_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
   
   end OberflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWaldLogik.Basiszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.Basisgrund));
      
      if
        GrundExtern.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         VorarbeitNötig := False;
         
      elsif
        True = RodenErmittelnLogik.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWaldLogik.Zusatzzeit (EinheitRasseNummerExtern.Rasse, GrundExtern.Zusatzgrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Wald_Aufforsten_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
      
   end UnterflächeWasser;

end WaldErmittelnLogik;
