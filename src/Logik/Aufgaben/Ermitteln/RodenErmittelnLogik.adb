with TextnummernKonstanten;
with ProduktionKonstanten;

with LeseWeltkarte;
  
with MeldungssystemHTB1;
with ArbeitszeitRodenLogik;
with MeldungFestlegenLogik;
with AufgabeFestlegenLogik;

package body RodenErmittelnLogik is

   function RodenErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
      use type ProduktionDatentypen.Arbeitszeit;
   begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserung,
                                                        SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
         return False;
         
      elsif
        ArbeitszeitRodenLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, Gesamtgrund.Basisgrund) = ProduktionKonstanten.UnmöglicheArbeit
      then
         return False;
         
      else
         null;
      end if;
      
      case
        Gesamtgrund.Basisgrund
      is
         when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             GrundExtern   => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                GrundExtern   => Gesamtgrund);
            
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
            MeldungssystemHTB1.Logik (MeldungExtern => "RodenErmittelnLogik.RodenErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
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
      
   end RodenErmitteln;
   
   
   
   function OberflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => ProduktionKonstanten.MinimaleArbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitRodenLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => Arbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitRodenLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      
      return (
              Aufgabe     => AufgabenDatentypen.Roden_Trockenlegen_Enum,
              Arbeitszeit => Arbeitszeit
             );
      
   end OberflächeLand;
   
     
     
   function UnterflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => ProduktionKonstanten.MinimaleArbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitRodenLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => Arbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitRodenLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      
      return (
              Aufgabe     => AufgabenDatentypen.Roden_Trockenlegen_Enum,
              Arbeitszeit => Arbeitszeit
             );
   
   end UnterflächeWasser;

end RodenErmittelnLogik;
