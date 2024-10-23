with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KIEbenebewertung is

   function EbeneBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.SenkrechteNatural
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Ebene;
   begin
      
      if
        NeueEbeneExtern = ZielebeneExtern
      then
         return 0;
         
      else
         Felderanzahl (1) := abs (Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern));
      end if;
      
      case
        LeseWeltkarteneinstellungen.EbeneOben
      is
         when KartenartDatentypen.Ebene_Übergangslos_Enum =>
            Felderanzahl (2) := KartenDatentypen.SenkrechtePositiv'Last;
            
         when KartenartDatentypen.Ebene_Übergang_Enum =>
            Felderanzahl (2) := StandardübergangOben (ZielebeneExtern => ZielebeneExtern,
                                                       NeueEbeneExtern => NeueEbeneExtern);
      end case;
      
      case
        LeseWeltkarteneinstellungen.EbeneUnten
      is
         when KartenartDatentypen.Ebene_Übergangslos_Enum =>
            Felderanzahl (3) := KartenDatentypen.SenkrechtePositiv'Last;
            
         when KartenartDatentypen.Ebene_Übergang_Enum =>
            Felderanzahl (3) := StandardübergangUnten (ZielebeneExtern => ZielebeneExtern,
                                                        NeueEbeneExtern => NeueEbeneExtern);
      end case;
      
      WelcheFelderanzahl := 1;
      
      BewertenSchleife:
      for BewertenSchleifenwert in FelderanzahlArray'Range loop
         
         if
           Felderanzahl (BewertenSchleifenwert) < Felderanzahl (WelcheFelderanzahl)
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         else
            null;
         end if;
                    
      end loop BewertenSchleife;
      
      return Felderanzahl (WelcheFelderanzahl);
   
   end EbeneBewerten;
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.SenkrechteNatural
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      if
        Ebenenumrechnung (NeueEbeneExtern) > Ebenenumrechnung (ZielebeneExtern)
      then
         return Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
                  
      else
         return KartenDatentypen.SenkrechtePositiv'Last;
      end if;
      
   end StandardübergangOben;
   
   
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.SenkrechteNatural
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      if
        Ebenenumrechnung (ZielebeneExtern) > Ebenenumrechnung (NeueEbeneExtern)
      then
         return Ebenenumrechnung (NeueEbeneExtern) - Ebenenumrechnung (ZielebeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
         
      else
         return KartenDatentypen.SenkrechtePositiv'Last;
      end if;
      
   end StandardübergangUnten;

end KIEbenebewertung;
