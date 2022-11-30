with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitentransporterLogik;

with KIDatentypen;
with KIKonstanten;

with KIBewegungAllgemeinLogik;
with KIBewegungsplanVereinfachenLogik;
with KIBewegungsbewertungLogik;

package body KIBewegungsplanBerechnenLogik is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                            AktuelleKoordinatenExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            AktuellePlanpositionExtern => 1);
      
      case
        PlanungErfolgreich
      is
         when True =>
            KIBewegungsplanVereinfachenLogik.Planvereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => EinheitenKonstanten.LeerBeschäftigung);
      end case;
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      then
         return False;
         
      else
         null;
      end if;
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in BewertungArray'Range loop
         
         Felderbewertung (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                          AktuelleKoordinatenExtern => AktuelleKoordinatenExtern);
         
         case
           PlanschrittFestlegen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                 DurchlaufExtern            => DurchlaufSchleifenwert,
                                 AktuellePlanpositionExtern => AktuellePlanpositionExtern)
         is
            when True =>
               return True;
               
            when False =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate,
                                                       PlanplatzExtern          => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   procedure Felderbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      BewertungPosition := BewertungArray'First;
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
               FeldBewertung (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert) := BewertungFeldposition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                       KoordinatenExtern        => AktuelleKoordinatenExtern,
                                                                                                                       EÄnderungExtern          => EAchseSchleifenwert,
                                                                                                                       YÄnderungExtern          => YAchseSchleifenwert,
                                                                                                                       XÄnderungExtern          => XAchseSchleifenwert);
               
               Bewertung (BewertungPosition) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, FeldBewertung (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               BewertungPosition := BewertungPosition + 1;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
                  
      SortierenEinsSchleife:
      for SortierenEinsSchleifenwert in BewertungArray'Range loop
         SortierenZweiSchleife:
         for SortierenZweiSchleifenwert in SortierenEinsSchleifenwert + 1 .. BewertungArray'Last loop
                           
            if
              Bewertung (SortierenEinsSchleifenwert).Bewertung > Bewertung (SortierenZweiSchleifenwert).Bewertung
            then
               Sortieren := Bewertung (SortierenEinsSchleifenwert);
               Bewertung (SortierenEinsSchleifenwert) := Bewertung (SortierenZweiSchleifenwert);
               Bewertung (SortierenZweiSchleifenwert) := Sortieren;
                  
            else
               null;
            end if;
               
         end loop SortierenZweiSchleife;
      end loop SortierenEinsSchleife;
      
   end Felderbewertung;
   
   
   
   function PlanschrittFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      case
        Bewertung (DurchlaufExtern).Bewertung
      is
         when KartenDatentypen.KartenfeldPositiv'Last =>
            return False;
               
         when KartenDatentypen.KartenfeldNatural'First =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => (Bewertung (DurchlaufExtern).EAchse, Bewertung (DurchlaufExtern).YAchse, Bewertung (DurchlaufExtern).XAchse),
                                                    PlanplatzExtern          => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => (Bewertung (DurchlaufExtern).EAchse, Bewertung (DurchlaufExtern).YAchse, Bewertung (DurchlaufExtern).XAchse),
                                                    PlanplatzExtern          => AktuellePlanpositionExtern);
            
            if
              AktuellePlanpositionExtern = EinheitenRecords.KIBewegungPlanArray'Last
            then
               return True;
         
            else
               return PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                      AktuelleKoordinatenExtern  => (Bewertung (DurchlaufExtern).EAchse,
                                                                     Bewertung (DurchlaufExtern).YAchse,
                                                                     Bewertung (DurchlaufExtern).XAchse),
                                      AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
            end if;
      end case;
      
   end PlanschrittFestlegen;
   
   
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EÄnderungExtern : in KartenDatentypen.EbenenbereichEins;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichEins;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichEins)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Ebene;
   begin
            
      if
        EÄnderungExtern = 0
        and
          YÄnderungExtern = 0
          and
            XÄnderungExtern = 0
      then
         return KartenDatentypen.KartenfeldNatural'Last;

      else
         KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                   ÄnderungExtern    => (EÄnderungExtern, YÄnderungExtern, XÄnderungExtern),
                                                                                                   LogikGrafikExtern => True);
      end if;
            
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return KartenDatentypen.KartenfeldNatural'Last;

         when others =>
            null;
      end case;
      
      case
        FeldBereitsBetreten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             KoordinatenExtern        => KartenWert)
      is
         when False =>
            null;
            
         when True =>
            return KartenDatentypen.KartenfeldNatural'Last;
      end case;
                  
      case
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  NeueKoordinatenExtern    => KartenWert)
      is
         when True =>
            null;
                        
         when False =>
            if
              True = TransporterNutzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        KoordinatenExtern        => KartenWert)
            then
               null;
               
            else
               return KartenDatentypen.KartenfeldNatural'Last;
            end if;
      end case;
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern    => KartenWert,
                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIKonstanten.BewegungAngriff | KIKonstanten.BewegungNormal =>
            return KIBewegungsbewertungLogik.Positionsbewertung (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                                                 AktuelleKoordinatenExtern => KoordinatenExtern,
                                                                 NeueKoordinatenExtern     => KartenWert);
            
            -- Hier später noch einmal anpassen. äöü
         when KIKonstanten.Tauschbewegung =>
            return KartenDatentypen.KartenfeldNatural'Last;
            
         when KIKonstanten.KeineBewegung =>
            return KartenDatentypen.KartenfeldNatural'Last;
      end case;
      
   end BewertungFeldposition;
   
   
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      FelderSchleife:
      for FelderSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
         
         if
           KoordinatenExtern = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   PlanschrittExtern        => FelderSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop FelderSchleife;
      
      return False;
      
   end FeldBereitsBetreten;
   
   
   
   function TransporterNutzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenDatentypen.MaximaleEinheiten'Range loop
         
         if
           EinheitRasseNummerExtern.Nummer = EinheitSchleifenwert
           or
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            null;
            
         elsif
           True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                                     TransporterExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert))
           and
             True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern    => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert),
                                                                              NeueKoordinatenExtern       => KoordinatenExtern)
         then
            -- Hier später True zurückgeben äöü
            null;
            
         else
            null;
         end if;
         
         -- Später entfernen äöü
         exit EinheitenSchleife;
         
      end loop EinheitenSchleife;
      
      return False;
      
   end TransporterNutzen;

end KIBewegungsplanBerechnenLogik;
