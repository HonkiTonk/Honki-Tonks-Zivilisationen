package StandardSpielwerteSetzenLogik is
   pragma Elaborate_Body;

   procedure Standardspielwerte
     (EinstellungenBehaltenExtern : in Boolean);

private

   procedure StandardspielwerteLogik
     (EinstellungenBehaltenExtern : in Boolean);

   procedure StandardspielwerteGrafik;

end StandardSpielwerteSetzenLogik;
