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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      then
         return False;
         
      else
         PlanungErfolgreich := PlanenRekursiv (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               AktuelleKoordinatenExtern  => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                               AktuellePlanpositionExtern => 1);
      end if;
      
      case
        PlanungErfolgreich
      is
         when True =>
            -- Das hier entfernen? Sollte vermutlich keine Bedeutung mehr haben mit dem neuen System? äöü
            KIBewegungsplanVereinfachenLogik.Planvereinfachung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Leer_Aufgabe_Enum);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => EinheitenKonstanten.LeerBeschäftigung);
      end case;
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   -- Den Teil hier mit BewegungsplanLogik verschmelzen? äöü
   function PlanenRekursiv
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is begin
      
      Felderbewertung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                       AktuelleKoordinatenExtern  => AktuelleKoordinatenExtern);
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in BewertungArray'Range loop
         
         case
           PlanschrittFestlegen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                 DurchlaufExtern            => DurchlaufSchleifenwert,
                                 AktuellePlanpositionExtern => AktuellePlanpositionExtern)
         is
            when True =>
               return True;
               
            when False =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => KartenRecordKonstanten.LeerKoordinate,
                                                       PlanplatzExtern            => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function PlanschrittFestlegen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      -- Muss hier für Windows zwischengespeichert werden, da sonst Bewertung (DurchlaufExtern).Koordinaten in PlanenRekursiv überschrieben wird und als neue AktuelleKoordinatenExtern in der Schleife verwendet wird.
      -- Gilt auch für BewegungsplanLogik und KIStaedteverbindungssystemLogik.
      -- Passiert nicht unter Linux, eventuell ein Kompilerfehler? Später, erst nach der Veröffentlichung von GNAT 13, mal nachprüfen.
      KoordinatenzwischenspeicherWindows := Bewertung (DurchlaufExtern).Koordinaten;
            
      case
        Bewertung (DurchlaufExtern).Bewertung
      is
         when KartenDatentypen.KartenfeldPositiv'Last =>
            return False;
               
         when KartenDatentypen.KartenfeldNatural'First =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => KoordinatenzwischenspeicherWindows,
                                                    PlanplatzExtern            => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => KoordinatenzwischenspeicherWindows,
                                                    PlanplatzExtern            => AktuellePlanpositionExtern);
            
            if
              AktuellePlanpositionExtern = EinheitenRecords.KIBewegungPlanArray'Last
            then
               return True;
         
            else
               return PlanenRekursiv (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                      AktuelleKoordinatenExtern  => KoordinatenzwischenspeicherWindows,
                                      AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
            end if;
      end case;
      
   end PlanschrittFestlegen;
   
   
   
   procedure Felderbewertung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      BewertungPosition := BewertungArray'First;
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               Bewertung (BewertungPosition).Koordinaten := KartenWert;
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
                 or
                   KartenWert = AktuelleKoordinatenExtern
               then
                  Bewertung (BewertungPosition).Bewertung := KartenDatentypen.KartenfeldPositiv'Last;
            
               else
                  Bewertung (BewertungPosition).Bewertung := BewertungFeldposition (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                    NeueKoordinatenExtern      => KartenWert);
               end if;
               
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
   
   
   
   function BewertungFeldposition
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      if
        True = FeldBereitsBetreten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    KoordinatenExtern          => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      else
         null;
      end if;
                  
      case
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                  NeueKoordinatenExtern      => NeueKoordinatenExtern)
      is
         when True =>
            null;
                        
         when False =>
            if
              True = TransporterNutzen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                        KoordinatenExtern          => NeueKoordinatenExtern)
            then
               null;
               
            else
               return KartenDatentypen.KartenfeldPositiv'Last;
            end if;
      end case;
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern      => NeueKoordinatenExtern,
                                               EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when KIKonstanten.BewegungAngriff | KIKonstanten.BewegungNormal | KIKonstanten.Tauschbewegung =>
            return KIBewegungsbewertungLogik.PositionsbewertungEinheit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                        NeueKoordinatenExtern      => NeueKoordinatenExtern);
            
         when KIKonstanten.KeineBewegung =>
            return KartenDatentypen.KartenfeldPositiv'Last;
      end case;
      
   end BewertungFeldposition;
   
   
   
   function FeldBereitsBetreten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      FelderSchleife:
      for FelderSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
         
         if
           KoordinatenExtern = LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                   PlanschrittExtern          => FelderSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop FelderSchleife;
      
      return False;
      
   end FeldBereitsBetreten;
   
   
   
   function TransporterNutzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) loop
         
         if
           EinheitSpeziesNummerExtern.Nummer = EinheitSchleifenwert
           or
             LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            null;
            
         elsif
           True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => EinheitSpeziesNummerExtern,
                                                                     TransporterExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitSchleifenwert))
           and
             True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitSchleifenwert),
                                                                              NeueKoordinatenExtern      => KoordinatenExtern)
         then
            -- Hier später True zurückgeben äöü
            -- return True;
            null;
            
         else
            null;
         end if;
         
         exit EinheitenSchleife;
                  
      end loop EinheitenSchleife;
      
      return False;
      
   end TransporterNutzen;

end KIBewegungsplanBerechnenLogik;
