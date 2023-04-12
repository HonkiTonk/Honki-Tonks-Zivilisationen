with EinheitenRecordKonstanten;
with TextnummernKonstanten;

with LeseWeltkarte;

with RodenErmittelnLogik;
with Fehlermeldungssystem;
with JaNeinLogik;
with ArbeitszeitWaldLogik;
with Grenzpruefungen;
with AufgabeFestlegenLogik;

package body WaldErmittelnLogik is

   function WaldErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitWaldLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, Gesamtgrund.Basisgrund)
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
          LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
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
            Arbeitswerte := OberflächeLand (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                             GrundExtern                => Gesamtgrund,
                                             AnlegenTestenExtern        => AnlegenTestenExtern,
                                             KoordinatenExtern          => KoordinatenExtern);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                GrundExtern                => Gesamtgrund,
                                                AnlegenTestenExtern        => AnlegenTestenExtern,
                                                KoordinatenExtern          => KoordinatenExtern);
            
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "WaldErmittelnLogik.WaldErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            AufgabeFestlegenLogik.AufgabeFestlegen (ArbeitExtern               => Arbeitswerte,
                                                    EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WaldErmitteln;
   
   
   
   function OberflächeLand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWaldLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
      if
        GrundExtern.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         VorarbeitNötig := False;
         
      elsif
        True = RodenErmittelnLogik.RodenErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   AnlegenTestenExtern        => AnlegenTestenExtern,
                                                   KoordinatenExtern          => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWaldLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitWaldLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
      if
        GrundExtern.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         VorarbeitNötig := False;
         
      elsif
        True = RodenErmittelnLogik.RodenErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   AnlegenTestenExtern        => AnlegenTestenExtern,
                                                   KoordinatenExtern          => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitWaldLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
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
