# Azure Landing Zone & M&A Docking Lab

Infrastructure as Code (Terraform) et gouvernance d'identité (Microsoft Entra ID) reproduisant un scénario d'intégration post-acquisition (_docking_).

## Architecture & Fonctionnalités

- **Terraform & Remote State :** Déploiement modulaire (`modules/network`) d'un Resource Group, VNet (2 subnets), NSG et Storage Account avec état distant stocké sur Azure Blob Storage et verrouillage natif (_Blob Lease_).
- **CI/CD :** Pipeline GitHub Actions exécutant `terraform fmt`, `validate` et `plan` sur chaque Pull Request.
- **Gouvernance & Sécurité Azure :** Gestion des accès RBAC (`Reader` vs `Contributor`), restriction géographique via Azure Policy (`Allowed locations`) et protection contre la suppression via Resource Locks (`CanNotDelete`).
- **Identité & SSO (Entra ID) :** Enregistrement d'une application OIDC, restriction d'accès par groupe de sécurité (_Assignment required_) et audit des connexions via les _Sign-in logs_.
