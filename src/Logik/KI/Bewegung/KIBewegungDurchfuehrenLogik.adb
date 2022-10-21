pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with KIKonstanten;

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

with KIBewegungBerechnenLogik;
with KIBewegungAllgemeinLogik;

package body KIBewegungDurchfuehrenLogik is
   
   procedure KIBewegung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      BewegungSchleife:
      loop
         
         if
           True = Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                   KoordinatenZweiExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                          RasseExtern       => EinheitRasseNummerExtern.Rasse)
           and
             False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                               NeueKoordinatenExtern    => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
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
              KIBewegungBerechnenLogik.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
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
      
      NeuePosition := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          PlanschrittExtern        => 1);
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern    => NeuePosition,
                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIKonstanten.BewegungNormal =>
            BewegtSich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.KeineBewegung =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.BewegungAngriff =>
            Blockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end BewegungDurchführen;
   
   
   
   procedure BewegtSich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
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
   is begin
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePosition,
                                                                             LogikGrafikExtern => True);
      FremdeStadt := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeuePosition);
            
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
