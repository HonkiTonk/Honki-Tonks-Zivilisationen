with RassenDatentypen;

package RassenKonstanten is
   pragma Pure;
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;

   LeerRassennummer : constant Natural := RassenDatentypen.Rassennummern'First;
   
   Rassenanfang : constant Positive := RassenDatentypen.RassennummernVorhanden'First;
   Rassenende : constant Positive := RassenDatentypen.RassennummernVorhanden'Last;

end RassenKonstanten;
