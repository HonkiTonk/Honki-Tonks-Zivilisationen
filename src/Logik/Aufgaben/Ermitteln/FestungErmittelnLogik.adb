with ProduktionKonstanten;

with LeseWeltkarte;

with MeldungssystemHTSEB;
with ArbeitszeitFestungLogik;
with AufgabeFestlegenLogik;

package body FestungErmittelnLogik is

   function FestungErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        ArbeitszeitFestungLogik.Basiszeit (EinheitSpeziesNummerExtern.Spezies, Gesamtgrund.Basisgrund)
      is
         when ProduktionKonstanten.UnmöglicheArbeit =>
            return False;
         
         when others =>
            null;
      end case;
                
      case
        Gesamtgrund.Basisgrund
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             GrundExtern   => Gesamtgrund);
            
         when KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                GrundExtern   => Gesamtgrund);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                              GrundExtern   => Gesamtgrund);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            null;
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "FestungErmittelnLogik.FestungErmitteln: Falsche Aufgabe: " & Arbeitswerte.Aufgabe'Wide_Wide_Image);
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
      
   end FestungErmitteln;
   
   
   
   function OberflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => ProduktionKonstanten.MinimaleArbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitFestungLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => Arbeitszeit,
                                               ZusatzwertExtern => ArbeitszeitFestungLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (
              Aufgabe     => AufgabenDatentypen.Festung_Bauen_Enum,
              Arbeitszeit => Arbeitszeit
             );
   
   end OberflächeLand;
     
   
   
   function UnterflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => ProduktionKonstanten.MinimaleArbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitFestungLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => Arbeitszeit,
                                               ZusatzwertExtern => ArbeitszeitFestungLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (
              Aufgabe     => AufgabenDatentypen.Festung_Bauen_Enum,
              Arbeitszeit => Arbeitszeit
             );
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => ProduktionKonstanten.MinimaleArbeitszeit,
                                         ZusatzwertExtern => ArbeitszeitFestungLogik.Basiszeit (SpeziesExtern, GrundExtern.Basisgrund));

      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;

         when others =>
            Arbeitszeit := ArbeitszeitPrüfen (GrundwertExtern  => Arbeitszeit,
                                               ZusatzwertExtern => ArbeitszeitFestungLogik.Zusatzzeit (SpeziesExtern, GrundExtern.Zusatzgrund));
      end case;
      
      return (
              Aufgabe     => AufgabenDatentypen.Festung_Bauen_Enum,
              Arbeitszeit => Arbeitszeit
             );
   
   end UnterflächeWasser;

end FestungErmittelnLogik;
