with KartengeneratorVariablenLogik;

package body KartengeneratorBasisberechnungenLogik is
   
   -- Die Startwerte sind dafür da dass die Landmassen auch ihre gesamte Größe haben und nicht abgeschnitten werden weil sie zu nahe am Rand sind.
   -- Später noch Prüfungen einbauen um sicherzustellen dass das Ganze nicht von beiden Seiten nicht passt. äöü
   function StartSenkrechte
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      AnfangExtern : in KartenDatentypen.SenkrechtePositiv;
      EndeExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      ÜbergangNorden := LeseWeltkarteneinstellungen.SenkrechteNorden;
      ÜbergangSüden := LeseWeltkarteneinstellungen.SenkrechteSüden;
      Schleifenbereich := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        ÜbergangNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
        and
          ÜbergangSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern - AnfangExtern < Schleifenbereich.MinimaleSenkrechte
         then
            return Schleifenbereich.MinimaleSenkrechte + AnfangExtern;
         
         elsif
           SenkrechteExtern + EndeExtern > Schleifenbereich.MaximaleSenkrechte
         then
            return Schleifenbereich.MaximaleSenkrechte - EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        ÜbergangNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern - AnfangExtern < Schleifenbereich.MinimaleSenkrechte
         then
            return Schleifenbereich.MinimaleSenkrechte + AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           SenkrechteExtern + EndeExtern > Schleifenbereich.MaximaleSenkrechte
         then
            return Schleifenbereich.MaximaleSenkrechte - EndeExtern;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return SenkrechteExtern;
      
   end StartSenkrechte;
   
   
   
   function StartWaagerechte
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      AnfangExtern : in KartenDatentypen.WaagerechtePositiv;
      EndeExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      ÜbergangWesten := LeseWeltkarteneinstellungen.WaagerechteWesten;
      ÜbergangOsten := LeseWeltkarteneinstellungen.WaagerechteOsten;
      Schleifenbereich := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      if
        ÜbergangWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
        and
          ÜbergangOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern - AnfangExtern < Schleifenbereich.MinimaleWaagerechte
         then
            return Schleifenbereich.MinimaleWaagerechte + AnfangExtern;
         
         elsif
           WaagerechteExtern + EndeExtern > Schleifenbereich.MaximaleWaagerechte
         then
            return Schleifenbereich.MaximaleWaagerechte - EndeExtern;
         
         else
            null;
         end if;
         
      elsif
        ÜbergangWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern - AnfangExtern < Schleifenbereich.MinimaleWaagerechte
         then
            return Schleifenbereich.MinimaleWaagerechte + AnfangExtern;
            
         else
            null;
         end if;
         
      elsif
        ÜbergangOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           WaagerechteExtern + EndeExtern > Schleifenbereich.MaximaleWaagerechte
         then
            return Schleifenbereich.MaximaleWaagerechte - EndeExtern;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return WaagerechteExtern;
      
   end StartWaagerechte;

end KartengeneratorBasisberechnungenLogik;
