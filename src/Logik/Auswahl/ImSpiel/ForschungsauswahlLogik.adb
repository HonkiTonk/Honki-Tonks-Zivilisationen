with TastenbelegungDatentypen;
with InteraktionAuswahl;
with GrafikDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;

with TasteneingabeLogik;
with MausauswahlLogik;
with NachGrafiktask;
with ForschungstestsLogik;

package body ForschungsauswahlLogik is

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
         
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      WasErforschtWerdenSoll := Forschungsmöglichkeiten (RasseExtern => RasseExtern);

      if
        WasErforschtWerdenSoll = ForschungKonstanten.LeerForschungsanforderung
        or
          WasErforschtWerdenSoll = AktuellesForschungsprojekt
      then
         null;
               
      else
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => WasErforschtWerdenSoll);
      end if;
      
   end Forschung;



   function Forschungsmöglichkeiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
   is begin

      ForschungSchleife:
      for ForschungenSchleifenwert in ForschungenDatentypen.ForschungID loop
         
         InteraktionAuswahl.MöglicheForschungen (ForschungenSchleifenwert) := ForschungstestsLogik.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                                                                                                  ForschungIDExtern => ForschungenSchleifenwert);
         
      end loop ForschungSchleife;
      
      return Forschungsauswahl;

   end Forschungsmöglichkeiten;
   
   
   
   function Forschungsauswahl
     return ForschungenDatentypen.ForschungIDMitNullWert
   is
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Forschung_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Forschungsmenü;
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := Natural (AktuelleAuswahl);
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = ForschungKonstanten.LeerForschungsanforderung
               then
                  null;
                  
               else
                  GewählteForschung := AktuelleAuswahl;
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               GewählteForschung := ForschungKonstanten.LeerForschungsanforderung;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      
      return GewählteForschung;
      
   end Forschungsauswahl;
   
   
   
   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      NachGrafiktask.AktuelleRasse := RasseExtern;
      Auswahl := 1;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Forschung_Erfolgreich_Enum;
      
      ErfolgSchleife:
      loop
         
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := Auswahl;
         
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
      
      -- Das Setzen auf Leer ist nötig damit die Grafik nicht die alte Forschung anzeigt, wenn man eine neue Forschung auswählt.
      SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                           ForschungIDExtern => ForschungKonstanten.LeerForschung);
      SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                           ForschungIDExtern => Forschungsmöglichkeiten (RasseExtern => RasseExtern));
      
      NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Rundenende_Enum;
      
   end Forschungserfolg;

end ForschungsauswahlLogik;
