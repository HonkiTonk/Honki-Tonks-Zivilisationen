with EinheitenDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with KIKonstanten;
with KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseWeltkarte;

with BewegungsberechnungEinheitenLogik;
with EinheitSuchenLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with Vergleiche;
with PassierbarkeitspruefungLogik;
with EinheitenbewegungLogik;

with KIBewegungsplanBerechnenLogik;
with KIBewegungAllgemeinLogik;

package body KIBewegungDurchfuehrenLogik is
   
   procedure KIBewegung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type EinheitenDatentypen.BewegungFloat;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BewegungSchleife:
      for BewegungSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradBewegung (SpielVariablen.Allgemeines.Schwierigkeitsgrad) loop
                  
         if
           True = Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                   KoordinatenZweiExtern => Zielkoordinaten)
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => Zielkoordinaten,
                                          RasseExtern       => EinheitRasseNummerExtern.Rasse)
           and
             False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                               NeueKoordinatenExtern    => Zielkoordinaten)
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         elsif
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) <= EinheitenKonstanten.LeerBewegungspunkte
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         elsif
           KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                       PlanschrittExtern        => 1)
         then
            case
              KIBewegungsplanBerechnenLogik.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
            is
               when True =>
                  null;
                  
               when False =>
                  return;
            end case;
            
         else
            BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end if;
         
      end loop BewegungSchleife;
      
   end KIBewegung;



   procedure BewegungDurchführen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      NeueKoordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlanschrittExtern        => 1);
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern    => NeueKoordinaten,
                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIKonstanten.BewegungNormal =>
            BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.Tauschbewegung =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            -- EinheitTauschen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
            --                 NeueKoordinatenExtern    => NeueKoordinaten);
            
         when KIKonstanten.KeineBewegung =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.BewegungAngriff =>
            Blockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end BewegungDurchführen;
   
   
   
   procedure EinheitTauschen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Tauscheinheit := (EinheitRasseNummerExtern.Rasse, EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                             KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                             LogikGrafikExtern => True));
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => Tauscheinheit)
      is
         when KIDatentypen.Platz_Machen_Enum | KIDatentypen.Leer_Aufgabe_Enum | KIDatentypen.Erkunden_Enum | KIDatentypen.Einheit_Auflösen_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      case
        EinheitenbewegungLogik.Einheitentausch (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                                StehendeEinheitExtern  => Tauscheinheit)
      is
         when True =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => Tauscheinheit);
            BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end EinheitTauschen;
   
   
   
   procedure BewegtSich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungsplan;
   begin
            
      BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             NeueKoordinatenExtern    => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             PlanschrittExtern        => 1),
                                                             EinheitentauschExtern    => False);
      
      BewegungPlanVerschiebenSchleife:
      for PositionSchleifenwert in EinheitenRecords.KIBewegungPlanArray'First + 1 .. EinheitenRecords.KIBewegungPlanArray'Last loop
         
         SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                 PlanschrittExtern        => PositionSchleifenwert),
                                                 PlanplatzExtern          => (PositionSchleifenwert - 1));
         
      end loop BewegungPlanVerschiebenSchleife;
            
      SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate,
                                              PlanplatzExtern          => EinheitenRecords.KIBewegungPlanArray'Last);
      
   end BewegtSich;
   
   
   
   procedure Blockiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinaten,
                                                                             LogikGrafikExtern => True);
      FremdeStadt := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeueKoordinaten);
            
      if
        FremdeStadt.Rasse = EinheitenKonstanten.LeerRasse
      then
         case
           KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern   => EinheitRasseNummerExtern,
                                                          VerteidigerExtern => FremdeEinheit)
         is
            when True =>
               BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when False =>
               null;
         end case;
         
      else
         case
           KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   VerteidigendeStadtRasseNummerExtern => FremdeStadt)
         is
            when True =>
               BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when False =>
               null;
         end case;
      end if;
         
   end Blockiert;

end KIBewegungDurchfuehrenLogik;
