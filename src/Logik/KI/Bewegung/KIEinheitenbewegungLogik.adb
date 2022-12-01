with EinheitenDatentypen;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseAllgemeines;

with BewegungsberechnungEinheitenLogik;
with EinheitSuchenLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with PassierbarkeitspruefungLogik;
with EinheitenbewegungLogik;
with BewegungspunkteBerechnenLogik;

with KIKonstanten;
with KIDatentypen;

with KIBewegungsplanBerechnenLogik;
with KIBewegungAllgemeinLogik;
with KIBewegungsplanVereinfachenLogik;
with KIEinheitHandlungstestsLogik;

package body KIEinheitenbewegungLogik is
   
   function Bewegung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      BewegungSchleife:
      for BewegungSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradBewegung (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when EinheitenKonstanten.LeerBewegungspunkte =>
               if
                 LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = Zielkoordinaten
               then
                  SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
                  SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
               else
                  null;
               end if;
               
               exit BewegungSchleife;
               
            when others =>
               null;
         end case;
            
         if
           LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = Zielkoordinaten
           or
             Zielkoordinaten = KartenRecordKonstanten.LeerKoordinate
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            exit BewegungSchleife;
            
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
            exit BewegungSchleife;
            
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
                  exit BewegungSchleife;
            end case;
            
         else
            BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end if;
         
      end loop BewegungSchleife;
      
      return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Bewegung;



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
            -- SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            -- Hier noch einmal genauer nachprüfen ob es auch wirklich funktioniert. äöü
            EinheitTauschen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             NeueKoordinatenExtern    => NeueKoordinaten);
            
         when KIKonstanten.KeineBewegung =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIKonstanten.BewegungAngriff =>
            Blockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end BewegungDurchführen;
   
   
   
   procedure EinheitTauschen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
            
      Tauscheinheit := (EinheitRasseNummerExtern.Rasse, EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                             KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                             LogikGrafikExtern => True));
      
      if
        Tauscheinheit.Nummer = EinheitRasseNummerExtern.Nummer
      then
         SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return;
         
      else
         null;
      end if;
      
     -- Aufgrund der Änderungen in EinheitenbewegungLogik.Einheitentausch wird das hier nicht mehr funktionieren, später also anpassen. äöü
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
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Bewegungsschritt := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              PlanschrittExtern        => 1);
      
      case
        BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern    => Bewegungsschritt,
                                                       EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerBewegungspunkte =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => False);
         
         when others =>
            BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern    => Bewegungsschritt,
                                                                   EinheitentauschExtern    => False);
      
            KIBewegungsplanVereinfachenLogik.BewegungsplanVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
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

end KIEinheitenbewegungLogik;
