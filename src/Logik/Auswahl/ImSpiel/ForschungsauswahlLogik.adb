with TastenbelegungDatentypen;
with InteraktionAuswahl;
with GrafikDatentypen;
with SpeziesKonstanten;
with TextnummernKonstanten;
with TonDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;
with SchreibeGrafiktask;
with SchreibeMusiktask;

with TasteneingabeLogik;
with MausauswahlLogik;
with ForschungstestsLogik;
with JaNeinLogik;

package body ForschungsauswahlLogik is

   procedure Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type ForschungenDatentypen.ForschungIDUnmöglich;
   begin
      
      NeuesForschungsprojekt := Forschungsmöglichkeiten (SpeziesExtern => SpeziesExtern);

      if
        NeuesForschungsprojekt = ForschungKonstanten.LeerAnforderung
        or
          NeuesForschungsprojekt = LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern)
      then
         null;
               
      else
         SchreibeWichtiges.Forschungsprojekt (SpeziesExtern     => SpeziesExtern,
                                              ForschungIDExtern => NeuesForschungsprojekt);
      end if;
      
   end Forschung;



   function Forschungsmöglichkeiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ForschungenDatentypen.ForschungID
   is begin

      ForschungSchleife:
      for ForschungenSchleifenwert in ForschungenDatentypen.ForschungIDVorhanden loop
         
         InteraktionAuswahl.MöglicheForschungen (ForschungenSchleifenwert) := ForschungstestsLogik.ForschungAnforderungErfüllt (SpeziesExtern     => SpeziesExtern,
                                                                                                                                  ForschungIDExtern => ForschungenSchleifenwert);
         
      end loop ForschungSchleife;
      
      return Forschungsauswahl (AktuellesForschungsprojektExtern => LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern));

   end Forschungsmöglichkeiten;
   
   
   
   function Forschungsauswahl
     (AktuellesForschungsprojektExtern : in ForschungenDatentypen.ForschungID)
      return ForschungenDatentypen.ForschungID
   is
      use type ForschungenDatentypen.ForschungIDUnmöglich;
   begin
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Forschung_Enum);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Forschungsmenü;
         SchreibeGrafiktask.Erstauswahl (AuswahlExtern => Natural (AktuelleAuswahl));
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = ForschungKonstanten.LeerAnforderung
               then
                  null;
                  
               elsif
                 (AktuelleAuswahl /= AktuellesForschungsprojektExtern
                  and
                    AktuellesForschungsprojektExtern /= ForschungKonstanten.LeerAnforderung)
                 and then
                   JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageForschungsprojektWechseln) = False
               then
                  null;
                  
               else
                  GewählteForschung := AktuelleAuswahl;
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               GewählteForschung := ForschungKonstanten.LeerAnforderung;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
      
      return GewählteForschung;
      
   end Forschungsauswahl;
   
   
   
   procedure Forschungserfolg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      SchreibeGrafiktask.AktiveSpezies (SpeziesExtern => SpeziesExtern);
      Auswahl := 1;
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Forschungserfolg_Enum);
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Forschung_Enum);
      
      ErfolgSchleife:
      loop
         
         SchreibeGrafiktask.Erstauswahl (AuswahlExtern => Auswahl);
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 Auswahl = 1
               then
                  Auswahl := 2;
                  
               else
                  exit ErfolgSchleife;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               if
                 Auswahl = 2
               then
                  Auswahl := 1;
                  
               else
                  exit ErfolgSchleife;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop ErfolgSchleife;
      
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Spiel_Enum);
      
      -- Das Setzen auf Leer ist nötig damit die Grafik nicht die alte Forschung anzeigt, wenn man eine neue Forschung auswählt.
      SchreibeWichtiges.Forschungsprojekt (SpeziesExtern     => SpeziesExtern,
                                           ForschungIDExtern => ForschungKonstanten.LeerForschung);
      SchreibeWichtiges.Forschungsprojekt (SpeziesExtern     => SpeziesExtern,
                                           ForschungIDExtern => Forschungsmöglichkeiten (SpeziesExtern => SpeziesExtern));
      
      SchreibeGrafiktask.AktiveSpezies (SpeziesExtern => SpeziesKonstanten.LeerSpezies);
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Rundenende_Enum);
      
   end Forschungserfolg;

end ForschungsauswahlLogik;
