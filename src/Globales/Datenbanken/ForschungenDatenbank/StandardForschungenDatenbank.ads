private with SpeziesDatentypen;

package StandardForschungenDatenbank is
   pragma Elaborate_Body;

   procedure StandardForschungenDatenbankLaden;

private

   procedure StandardTechnologienLaden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);

end StandardForschungenDatenbank;
