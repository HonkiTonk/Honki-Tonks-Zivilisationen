with EinheitenRecordKonstanten;

with LeseWeltkarte;

with RodenErmittelnLogik;
with Fehlermeldungssystem;
with ArbeitszeitMineLogik;
with Grenzpruefungen;
with AufgabeFestlegenLogik;

package body MineErmittelnLogik is

   function MineErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitMineLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, Gesamtgrund.Basisgrund)
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
            Arbeitswerte := OberflächeLand (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                             GrundExtern                => Gesamtgrund,
                                             AnlegenTestenExtern        => AnlegenTestenExtern,
                                             KoordinatenExtern          => KoordinatenExtern);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                GrundExtern                => Gesamtgrund,
                                                AnlegenTestenExtern        => AnlegenTestenExtern,
                                                KoordinatenExtern          => KoordinatenExtern);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              GrundExtern                => Gesamtgrund);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Mine_Bauen_Enum =>
            null;
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "MineErmittelnLogik.MineErmitteln: Falsche Aufgabe:" & Arbeitswerte.Aufgabe'Wide_Wide_Image);
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
      
   end MineErmitteln;
   
   
   
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
                                                  ÄnderungExtern      => ArbeitszeitMineLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
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
                                                     ÄnderungExtern      => ArbeitszeitMineLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Mine_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
   
   end OberflächeLand;
   
   
     
   function UnterflächeLand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitMineLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
      if
        GrundExtern.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         VorarbeitNötig := False;
         
      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitMineLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
         VorarbeitNötig := False;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Mine_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
      
   end UnterflächeLand;
     
     
     
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
                                                  ÄnderungExtern      => ArbeitszeitMineLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
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
                                                     ÄnderungExtern      => ArbeitszeitMineLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Mine_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
      
   end UnterflächeWasser;

end MineErmittelnLogik;
