private with RassenDatentypen;

package StandardForschungenDatenbank is
   pragma Elaborate_Body;

   procedure StandardForschungenDatenbankLaden;

private

   procedure StandardTechnologienLaden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

end StandardForschungenDatenbank;
