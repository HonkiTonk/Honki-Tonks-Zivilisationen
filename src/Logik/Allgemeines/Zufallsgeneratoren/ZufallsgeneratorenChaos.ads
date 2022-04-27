pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenGrundDatentypen;

package ZufallsgeneratorenChaos is

   function ChaoskarteGrund
     return KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;
   
   function ChaoskarteFluss
     return KartenGrundDatentypen.Karten_Fluss_Enum;
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
      return KartenGrundDatentypen.Karten_Ressourcen_Enum;

   function TotaleChaoskarteGrund
     return KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;
   
   function TotaleChaoskarteFluss
     return KartenGrundDatentypen.Karten_Fluss_Enum;
   
   function TotaleChaoskarteRessource
     return KartenGrundDatentypen.Karten_Ressourcen_Enum;
   
private
      
   RessourceWert : KartenGrundDatentypen.Karten_Ressourcen_Enum;
   
   GrundWert : KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;

   package WerteWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartenGrundDatentypen.Kartengrund_Vorhanden_Enum);
   GrundGewählt : WerteWählenChaoskarte.Generator;
   
   package FlussWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartenGrundDatentypen.Karten_Fluss_Enum);
   FlussGewählt : FlussWählenChaoskarte.Generator;
   
   package RessourceWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartenGrundDatentypen.Karten_Ressourcen_Enum);
   RessourceGewählt : RessourceWählenChaoskarte.Generator;

end ZufallsgeneratorenChaos;
