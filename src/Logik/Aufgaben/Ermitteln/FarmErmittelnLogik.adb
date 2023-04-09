with EinheitenRecordKonstanten;

with LeseWeltkarte;

with RodenErmittelnLogik;
with Fehlermeldungssystem;
with ArbeitszeitFarmLogik;
with Grenzpruefungen;
with AufgabeFestlegenLogik;

package body FarmErmittelnLogik is

   function FarmErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitFarmLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, Gesamtgrund.Basisgrund)
      is
         when EinheitenKonstanten.UnmöglicheArbeit =>
            return False;
         
         when others =>
            null;
      end case;

      if
        Gesamtgrund.Basisgrund = KartengrundDatentypen.Eis_Enum
      then
         return False;

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
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            null;
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "FarmErmittelnLogik.FarmErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
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
      
   end FarmErmitteln;
   
   
   
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
                                                  ÄnderungExtern      => ArbeitszeitFarmLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
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
                                                     ÄnderungExtern      => ArbeitszeitFarmLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Farm_Bauen_Enum,
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
                                                  ÄnderungExtern      => ArbeitszeitFarmLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
      if
        GrundExtern.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         VorarbeitNötig := False;
         
      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitFarmLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
         VorarbeitNötig := False;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Farm_Bauen_Enum,
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
                                                  ÄnderungExtern      => ArbeitszeitFarmLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Basisgrund));
      
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
                                                     ÄnderungExtern      => ArbeitszeitFarmLogik.Zusatzzeit (EinheitSpeziesNummerExtern.Spezies, GrundExtern.Zusatzgrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Farm_Bauen_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
   
   end UnterflächeWasser;

end FarmErmittelnLogik;
